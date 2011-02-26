From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Adding Beyond Compare as a merge tool, was: Re: What's cooking in
 git.git (Feb 2011, #05; Wed, 23)
Date: Sat, 26 Feb 2011 11:48:41 +0100
Message-ID: <AANLkTikP2KsjTijvFbyGZZ28BHV8T3NF0BEcatK2EpCL@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<4D68D4FA.7090500@gmail.com>
	<7voc5z6q6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: judge.packham@gmail.com, git@vger.kernel.org, charles@hashpling.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 11:48:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtHhn-0006PX-Vf
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 11:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab1BZKsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 05:48:43 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45504 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1BZKsm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 05:48:42 -0500
Received: by qwd7 with SMTP id 7so1806068qwd.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QP57bPZSc/bdK9b/Br1oaL7s4654mfBNHxFQ28vDyCk=;
        b=q30+9mArh8Rtf+quX4epFbGBtbUVoIdrNNcAeezDIBEc4k/lZqK/js9z8P1DLTqup7
         oGhRjduPgQSTEeanKiGAMnhViH9L5yLd+dR8+8Q3Cg1FEtnATa8jLyqc/zFPcy9f4UH/
         I8zYu0G4M78GYMWteu3k1/ofuTaz0VJnhxc5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wjkdH20IHfUjuHGnaJtaoZWBm8wrf6C8rkApNgUn5BibllazevW2qnHCQv73rmhjY/
         cpArSszAH9UhUhrvJUYujsZr/9G3rQ5+vjryvXDuvYr1jdNPx/CQ1E44dO987Ub5LW8z
         664VDoSqbD1Y3HQyTn0zv4RaiuUw1kYPUtY2Q=
Received: by 10.229.217.212 with SMTP id hn20mr2478550qcb.225.1298717321548;
 Sat, 26 Feb 2011 02:48:41 -0800 (PST)
Received: by 10.229.17.73 with HTTP; Sat, 26 Feb 2011 02:48:41 -0800 (PST)
In-Reply-To: <7voc5z6q6r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167973>

On Sat, Feb 26, 2011 at 11:33, Junio C Hamano <gitster@pobox.com> wrote:

>> For your convenience, I've rebased onto the current master and
>> attached the patch files.
>
> Could we be even more greedy (and lazy) and ask you to send them as a
> three-patch series, one-patch-per-message and plain-text, as well, so that
> these can be discussed on-list just like any other patches?

Will do ...

-- 
Sebastian Schuberth
