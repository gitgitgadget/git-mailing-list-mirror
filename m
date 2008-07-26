From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Summer of Code 2008 Midterm Summary
Date: Sat, 26 Jul 2008 18:27:43 -0500
Message-ID: <20080726232743.GA16870@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 01:28:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMtC4-0001YP-2y
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 01:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755600AbYGZX1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 19:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755350AbYGZX1p
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 19:27:45 -0400
Received: from george.spearce.org ([209.20.77.23]:45394 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYGZX1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 19:27:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id ED8AF383A5; Sat, 26 Jul 2008 23:27:43 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90294>

Part of the Google Summer of Code program is to ask the students
to evaluate their mentors, and their own involvement with their
community.  That evaluation period closed on July 14th, but I
haven't had a chance to go through the results until now.

At the mid-term all 6 of our students "passed" their evaluations.
This means we asked Google to pay out their $2000 USD stipend, and
allow the student to continue the program for the rest of the summer.
This decision was made by each individual mentor.  Payment of the
remaining $2000 USD stipend will be determined during the final
evaluations, which are after August 11th.

What follows is a condensed summary of the student responses from
the mid-term survey.

Q: At what point did you first make contact with your
   mentoring organization?

   This was about split 50/50 between "after the organization was
   accepted" and "during the student application and acceptance
   phase of the program".  As you may well know, Summer of Code
   takes a short 'break' between announcing what organizations will
   participate as mentors, and when students can begin applying.

   The fact that about 50% of our accepted students were talking to
   our potential mentors before they could even submit applications
   suggests that it worked in their favor, and improved their odds
   of being selected.

   Since this was a significant part of our application selection
   process, I am not surprised by this figure.

Q: How often do you and your mentor interact?

   2 students answered "Every day" and 4 answered "once every few
   days".  By and large our mentors are active with their students.

Q: How do you communicate with your mentor?

   Overwhelmingly our students use IRC and private emails to
   communicate with their mentors.

   Most of them also keep a private Git repository with a list of
   notes they want to share with their mentor, and their mentors
   monitor this notes file by git-fetch'ing it every so often.
   It seems we eat our own dog food quite a bit around here.  :-)

Q: How much time have you spent per week interacting with your
   mentor, on average?

   All of our students (except 1) said 0-5 hours per week, and the
   lone dissenter said 6-10 hours per week.  Nearly all of the
   mentors on the other hand chose 6-10 hours per week in their
   own surveys.

   It may be safe to say that in the average case we are spending
   about 10 hours per week as mentors just communicating with our
   students and helping them to meet their goals.

Q: How would you describe your interaction with your overall
   project community?

   5 out of 6 of our students said "Somewhat active (e.g. I read
   and sometimes responds to mailing lists, some interaction in
   community communication channels)".  I think most of them really
   should have chosen instead "Very active (e.g. I send code reviews
   to development mailing lists, am active and ask/answer questions
   in our IRC channel or project forums)".

   Most of our summer of code students _are_ sending code reviews
   to this mailing list, and are taking advantage of the fantastic
   contributors we have to help them out.  They also tend to answer
   questions on IRC and the mailing list when they are pretty sure
   they know the answer and can take the time to help someone else.

   Certainly our students aren't as active as our intrepid maintainer
   is, but most of them aren't lurking in the shadows either.

Q: If you cannot reach your mentor, how do you go about getting
   help when you need it?

   3 of our students selected "I hope I can figure it out myself
   before my mentor resurfaces.".  This is a less-than-optimal result
   in my opinion.  Despite the prior question indicating that our
   students may actually be actively involved in the community
   they don't feel involved enough to obtain assistance without
   their mentor.

   3 students also chose "I ask questions on our project's developer
   or other main mailing list.".

   This was a multiple choice question, so there is some overlap,
   but I do know that at least one student chose _only_ "I hope
   I can figure it out myself before my mentor resurfaces".

   In terms of community building this question's answers seem to
   suggest we need to try harder to make our students included,
   and get help beyond just their mentor/co-mentor.

Q: How responsive was your mentor to any questions or other requests
   for communication from you?

   All of our students chose "Mentor responded quickly with the
   information I requested" (which is the best rating available),
   though one of them qualified it with "For some values of
   'quickly'".  ;-)

Q: Do you feel that you are on track to complete your project?

   I'm not sure if this is good or bad.  3 students (50%!) are
   ahead of schedule, 1 is on schedule, and 2 are behind.

   On the one hand I applaud our 3 students who happen to be ahead
   of schedule.  They have clearly worked hard and produced some
   useful code, much of which will be in the next release of their
   respective projects.

   On the other hand I wonder if as mentors we didn't demand
   enough of our students?  Looking at the students who are ahead
   of schedule, I know that at least 2 of them had what we thought
   as mentors to be difficult, time consuming tasks in front them.
   So we did intentially try to define the project such that it
   would be more likely to succeed.

Q: What areas were the most difficult for you in preparing
   for/working on Summer of Code?

   Most of our students (5/6) had trouble balancing their time
   between their Git project and school (exams, etc.).  This is a
   common theme in Summer of Code and Git isn't alone in seeing it.
   As I understand it a number of our students are in European
   based university programs, which causes exams to fall in the
   early part of the Summer of Code timeline.

   Half of our students found getting up to speed with our code
   base and/or documentation was difficult.  In other words, they
   did not feel that Git was "new contributor friendly".

   A couple of students have had time-zone issues with their mentors,
   but looking at the progress of most projects that doesn't seem
   to be a major issue.

-- 
Shawn.
