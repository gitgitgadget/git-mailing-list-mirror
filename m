From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 18:10:05 +0200
Message-ID: <87ppvszl0i.fsf@linux-k42r.v.cablecom.net>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com>
	<51B6AA7F.1060505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"A Large Angry SCM" <gitzilla@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 18:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmR9C-0006t7-JH
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 18:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861Ab3FKQKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 12:10:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:14972 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab3FKQKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 12:10:08 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 11 Jun
 2013 18:10:02 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 11 Jun 2013 18:10:04 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227457>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Accept reviewers' comments gratefully and take them very seriously.
> Show that you appreciate the help by giving the reviewer the benefit of
> the doubt.  If, after careful consideration, you find that you cannot
> agree with a reviewer's suggestion, explain your reasoning carefully
> without taking or giving offense, and seek compromise.

I'm not sure yet how to phrase it, but I have come to the conclusion
that the dual nature of reviews is part of the problem.

On the one hand, reviews are code criticism: they are extra work spent
by the reviewer to try and help you improve your work.

On the other hand, they are also quality checks.  Reviews serve to spot
bugs, misdesigns, noncompliance with project standards, etc. before they
ever go into the code base.

The problems start when these start having a contradictory impact on the
correct course of action in a discussion, or in the longer term in
dealing with a person.  For example, I have attempted to deal with
Felipe at one point by refusing to review, i.e., ignore the email.

However, this must be weighed against the requirements of the second
kind of review.  So while it is exceedingly easy for everyone to say
"just ignore the flamebait", the flamewars keep recurring because this
"gatekeeper" type of review continues to be necessary, and continues to
elicit nonconstructive responses.

The "easy" solution is to simply stop taking patches from Felipe, but
opens pandora's box w.r.t. the just application of such a measure, as
Ram has noted repeatedly.

Yet that is the only measure that I currently know that both keeps up
code review standards and has any hope of improving the current climate.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
