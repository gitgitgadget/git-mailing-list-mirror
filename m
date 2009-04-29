From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Cross-Platform Version Control (was: Eric Sink's blog - notes on 
	git, dscms and a "whole product" approach)
Date: Wed, 29 Apr 2009 08:55:29 +0200
Message-ID: <46a038f90904282355g43bf0cv909905f6028f054f@mail.gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	 <m3r5zdnhqu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:55:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3hp-0004j0-0E
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbZD2Gzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbZD2Gzb
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:55:31 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:33814 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbZD2Gzb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 02:55:31 -0400
Received: by bwz7 with SMTP id 7so974586bwz.37
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 23:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PTm6jR7plbHgCF1e5fRIkFQvs051n/1NCX4FXQ0+37k=;
        b=K4otH37s+KEm4h1yIOb8TYtHgp7aAWADD1r8DagUmuyZx5BKBB0xqmXsq/dlHVUyNc
         m72vc67wlVjs/MikRNGhqNrwLa8Jqljb/gn7g4UXZxh9yA/MU4OgoNHI7mvLa0mv8D+a
         3ADOAqZbqya16p3iwZFKtxpS8ZlPYRHJnlG2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QwVV7imEBNSgjXaaxYLyqRa8UKYW2e5Ik5wzJUnXF0SPuSOCFbPUxLoGn+5igDLn8e
         Wc2h3kIu3aQVTB3T14jueTef1sTcksJ3KCvIbm7ogcmmaOUKtJYwcMeB+x6s0fAdViEk
         73tyAu7fHfFUEwByllFya3lBz3i7+KDZ8FX1Y=
Received: by 10.223.118.141 with SMTP id v13mr2679680faq.26.1240988129615; 
	Tue, 28 Apr 2009 23:55:29 -0700 (PDT)
In-Reply-To: <m3r5zdnhqu.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117858>

On Tue, Apr 28, 2009 at 1:24 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> =A0 DON'T DO THAT.
> =A0 DON'T DO THAT, SOLVABLE.

As I mentioned, Eric is taking the perspective of offering a supported
SCM to a large and diverse audience. As such, his notes are
interesting not because he's right or he's wrong.

We can be "right" and say "don't do that" if we shrink our audience so
that it looks a lot like us. There, fixed.

But something tells me that successful tools are -- by definition --
tools that grow past their creators use.

So from Eric's perspective, it is worthwhile to work on all those
issues, and get the right for the end user -- support things we don't
like, offer foolproof catches and warnings that prevent the user from
shooting their lovely toes off to mars, etc.

His perspective is one of commercial licensing, but even if we aren't
driven by the "each new user is a new dollar" bit, the long term hopes
for git might also be to be widely used and to improve the version
control life of many unsuspecting users.

To get there, I suspect we have to understand more of Eric's perspectiv=
e.

that's my 2c.



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
