From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 09:43:23 -0700
Message-ID: <7vwsjcft5g.fsf@gitster.siamese.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com>
 <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness>
 <200807231508.42334.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhSf-0003oW-Pc
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYGWQoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbYGWQoH
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:44:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbYGWQoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:44:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7037338093;
	Wed, 23 Jul 2008 12:43:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D13AD38090; Wed, 23 Jul 2008 12:43:40 -0400 (EDT)
In-Reply-To: <200807231508.42334.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 23 Jul 2008 15:08:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8559A388-58D6-11DD-ABEF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89705>

Jakub Narebski <jnareb@gmail.com> writes:

> On Wed, 23 Jul 2008, Johannes Schindelin wrote:
>> On Wed, 23 Jul 2008, Jakub Narebski wrote:
>> 
>> Some people prefer to stay anonymous, so I think email is out.
>> 
>> >    04. Which programming languages you are proficient with?
>> >        (The choices include programming languages used by git)
>> >        (zero or more: multiple choice)
>> >      - C, shell, Perl, Python, Tcl/Tk
>> >      + (should we include other languages, like C++, Java, PHP,
>> >         Ruby,...?)
>> 
>> Yes, I think this should be a long list.
>
> I'd rather not have a "laundry list" of languages.  I have put C++
> because QGit uses it, Java because of egit/jgit, PHP for web
> interfaces, Ruby because of GitHub and because of Ruby comminity
> choosing Git.  I should perhaps add Emacs Lisp, HTML+CSS and
> JavaScript here.  What other languages should be considered?

I refrained saying this in my initial response, but my initial reaction
was "Why are you even asking this?".

Yes, "getting to know you" demographics are customary done in surveys, and
you kept it to the minimum which is also good, but I do not think this
particular question is very interesting.  For one thing, the question
assumes the participant is a programmer, and we are giving an impression
that we are interested in better programmers.  Do we *still* require users
to be a programmer to use git?  I do not think so.  Having to answer "none
of these" to this question would make you feel unnecessarily bad, even if
you are not a programmer and you know at the intellectual level that it is
not your flaw not to be proficient in any.

Asking about geographic location and preferred human languages might help
to gauge what l10n are desired for GUIs, but even there, don't forget that
we are no company.  We do not research markets and translate messages to
missing languages, however popular, before being asked.  That's not how we
operate.  So the result of these questions will be mainly to satisfy our
curiosity, nothing more.

"What kind of content do you track" might also be an equally interesting
question.  It also falls into the curiosity department, though.

> I'm not sure about having multiple choice vs. free-form question here.
> Multiple choice is easier to analyze, especially if one would want
> histogram of replies...

And when you expect very many respondents, (1) you cannot afford to
free-form; and (2) statistics over multiple choices, as long as choices
are well seeded, will give you a good enough overview picture.

> Again: free form has some hassles, but so does coming up with good
> choice of fixed answers in multiple choice question.

You need to do at least one or the other, and I do not think there is any
way to avoid that.  Without a good choices, histogram would become useless
(not necessarily because the answer will be dominated by "Other", but the
seeing the choices tends to set the frame of mind when/before somebody
answers the question).  With free-form, you will spend the rest of your
life analyzing to get any useful insight.
