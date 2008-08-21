From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Wed, 20 Aug 2008 20:10:41 -0700
Message-ID: <7vljyrkqq6.fsf@gitster.siamese.dyndns.org>
References: <200807230325.04184.jnareb@gmail.com>
 <200808200308.26308.jnareb@gmail.com>
 <7v4p5fqw91.fsf@gitster.siamese.dyndns.org>
 <200808210330.44908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 05:12:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW0b7-00076r-7j
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 05:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbYHUDKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 23:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756403AbYHUDKu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 23:10:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbYHUDKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 23:10:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCCD3588DF;
	Wed, 20 Aug 2008 23:10:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 24189588DE; Wed, 20 Aug 2008 23:10:42 -0400 (EDT)
In-Reply-To: <200808210330.44908.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu, 21 Aug 2008 03:30:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF41915A-6F2E-11DD-BE16-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93096>

Jakub Narebski <jnareb@gmail.com> writes:

>> >    xx. Which Git version(s) are you using?
>> >        (zero or more, multiple choice:
>> >         one can use different versions on different machines)
>> >      - pre 1.3, 1.3, 1.4, 1.5, 1.6, master, next
>> >      + might be important when checking "what did you find hardest" etc.
>> 
>> This is a very good idea.  "What is hardest" grouped by "How proficient
>> are you with git".
>
> Errr... I didn't add "How proficient are you with git?" question to
> Git User's Survey 2008, but I think I would.

I meant that "how long have you been using" already has a strong correlation
to the proficiency (iow I did not mean to suggest adding a new question).

>> s/separate worktree/& (git-new-workdir)/;
>
> Or core.worktree.

As I personally do not think there is any sane usecase that *must* use
core.worktree and/or GIT_WORK_TREE, I took "separate worktree" as "having
two or more worktree on the same repository via new-workdir mechanism",
but you meant core.worktree.  It shows the question is ill-stated that
there are confusion even between us.

>> > Documentation
>> >
>> >    xx. What could be improved on the Git homepage?
>> >        (free form)
>> >    xx. What could be improved in Git documentation?
>> >        (free form)
>> 
>> "What can/will you do to help improve them?"?
>
> Good idea.  I have added this, separately for each question...

Wouldn't that be an overkill?
