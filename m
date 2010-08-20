From: Joshua Juran <jjuran@gmail.com>
Subject: Re: git commands
Date: Fri, 20 Aug 2010 00:32:18 -0700
Message-ID: <5F6739C3-B537-4694-BC63-F3F74962A47C@gmail.com>
References: <1282288658094-5443370.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 09:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmM5l-0005Yt-60
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 09:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164Ab0HTHcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 03:32:23 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55980 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab0HTHcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 03:32:21 -0400
Received: by pxi10 with SMTP id 10so1096323pxi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 00:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=wPZtV6h/b0SEfKjPTLxRQZZ+LhdViL1T4Gy71V9G3FQ=;
        b=db3mJe984CF5L0chOhAkKLFLS95PvJi/wnD/wYJEg1BQSEYTu1dGh6eqo6ty9Od2e/
         QfvuuxQxubZLIKp6Nm9N/u4PcIC72/yhwE/DU92TVCZ8qAPi/JVzFLltxalzYYiTGfmW
         D/u1mk2SCfQNRBlGZuEoR6WF84K12W3hsvC/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=u2AJxdV7SVr7bzCBPFP5+lFQZoXfAD270qmYgjCrzubjAhkJm8sWtu4IUF3LopB4c8
         YE7OVXlZlf3pb9QsfppvuzGp/gjf55sVSfEwDTufcKp0NYFEryI9ZMP5C3YFppP6kT6I
         N1vQtWjyeVV8lN1O5VTzKZzqWIvmcsZToN578=
Received: by 10.142.14.6 with SMTP id 6mr753839wfn.198.1282289541388;
        Fri, 20 Aug 2010 00:32:21 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id b19sm2836435wff.7.2010.08.20.00.32.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 00:32:20 -0700 (PDT)
In-Reply-To: <1282288658094-5443370.post@n2.nabble.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153980>

On Aug 20, 2010, at 12:17 AM, sandy2010 wrote:

> I'm new to git and I wonder what is the difference between two  
> commands:
>
> "git clone" and "git-clone" and which one should be use?


They're the same command.  You should use the first form to actually  
run the command and the hyphenated form for consulting the manual:

	git clone git://git.kernel.org/pub/scm/git/git.git

	man git-clone

You may get speedier responses to easy questions on IRC, in #git.

Cheers,
Josh
