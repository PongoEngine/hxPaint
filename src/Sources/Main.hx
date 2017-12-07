/*
 * Copyright (c) 2017 Jeremy Meltingtallow
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package;

import kha.System;

import pongo.Origin;
import perdita.Update;
import perdita.Msg;

import jasper.C;
import jasper.EditInfo;
import jasper.Expression;
import jasper.Hashable;
import jasper.HashSet;
import jasper.HashTable;
import jasper.Point;
import jasper.SimplexSolver;
import jasper.Strength;
import jasper.SymbolicWeight;
import jasper.Tableau;

import jasper.constraint.AbstractConstraint;
import jasper.constraint.Constraint;
import jasper.constraint.EditConstraint;
import jasper.constraint.Equation;
import jasper.constraint.Inequality;
import jasper.constraint.StayConstraint;

import jasper.error.ConstraintNotFound;
import jasper.error.Error;
import jasper.error.InternalError;
import jasper.error.NonExpression;
import jasper.error.NotEnoughStays;
import jasper.error.RequiredFailure;
import jasper.error.TooDifficult;

import jasper.variable.AbstractValue;
import jasper.variable.AbstractVariable;
import jasper.variable.AbstractVariableArgs;
import jasper.variable.DummyVariable;
import jasper.variable.ObjectiveVariable;
import jasper.variable.SlackVariable;
import jasper.variable.Variable;

class Main {
    public static function main() : Void
    {
        System.init({title: "Perdita", width: 1366, height: 768}, function() {
                var model = null;
                new Origin(model, INIT_GUI, Update.update);
        });
    }
}