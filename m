From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Fri, 26 Jun 2009 16:57:25 -0700
Message-ID: <7vvdmipmze.fsf@alter.siamese.dyndns.org>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
	<200906261133.47326.jnareb@gmail.com>
	<cb7bb73a0906261106n5e12948dydd02bd8d1b19a5e6@mail.gmail.com>
	<7vmy7ur5dz.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0906261557q52f2536nb778b2882e979b2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 01:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLIT-0001SJ-H4
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 01:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZFZX5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 19:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZFZX5X
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 19:57:23 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60610 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZFZX5X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 19:57:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090626235725.DWBG20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 26 Jun 2009 19:57:25 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8nxR1c00D4aMwMQ04nxRuQ; Fri, 26 Jun 2009 19:57:25 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=QvAk5OigKbwA:10 a=pGLkceISAAAA:8
 a=JR8GgomjDYkUOR43O6EA:9 a=E8Vd4nQfnlPpANUARlZ5qqMy7M8A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0906261557q52f2536nb778b2882e979b2b@mail.gmail.com> (Giuseppe Bilotta's message of "Sat\, 27 Jun 2009 00\:57\:56 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122338>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> What's your opinion on the alignment for the date column in the shortlog?

Even though I am very used to seeing the current output style that aligns
to the left edge, your output didn't bother me.  

Because visual preference typically is influenced very heavily by inertia,
I take this as a sign that (1) left or right it does not matter very much,
and/or (2) aligning to the right edge is slightly better.

But that is just my impression.
