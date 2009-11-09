From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: gitk : french translation
Date: Mon, 9 Nov 2009 02:24:14 +0100
Message-ID: <20091109012414.GA15022@vidovic>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <b0c32d010911061016t2208af0er8d7fe88508c30f10@mail.gmail.com> <9f50533b0911061259w54b57fcdo2c0b21e95dbbdc54@mail.gmail.com> <20091107025439.GC13724@vidovic> <9f50533b0911080955l606ea87aw4edd7b0bc926a25f@mail.gmail.com> <20091108214130.GA12931@vidovic> <4AF7502A.9020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Emmanuel Trillaud <etrillaud@gmail.com>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Maximilien Noal <noal.maximilien@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 02:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7J2Q-0004KH-JE
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 02:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZKIBYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 20:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZKIBYQ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 20:24:16 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:63064 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbZKIBYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 20:24:15 -0500
Received: by ewy3 with SMTP id 3so2705121ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=QKMlIaV5UnZD0edQsQ9nhLXlt7X2x2dI+d+AAwxnRs4=;
        b=Wlqu6zKORkE9HcKS+Zmt0AH68f0LeA3dO9zZH1ZZGVdMOjzYeRI34LcVyTzafFctZZ
         32K8ZbMvAwHv63AbhXO+4G139Y10LUDfo0GGV6QzcfqgR7vZefOdk8vUTnb8dFGG9Ts7
         /hb1MyzFORtIMeyjej1oSyxbE3h5EGSK2CY0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RnfPEFe2HxUMwxiv0rrTL9fdDN6YebKZ49OEMb3Q6LDlufAE4NOPKzNUUwroMDE9sv
         oZGVW+AojTTXpb36Auq8oI/Kjlg/ufVe9+k9ZREhtR6olu1UkTOuIENmvpxPiZwoSD1i
         ckmgrznZ6xAPA9IJCadqL5Gp/9LgedvL6CvYw=
Received: by 10.213.2.71 with SMTP id 7mr2508453ebi.88.1257729858628;
        Sun, 08 Nov 2009 17:24:18 -0800 (PST)
Received: from @ (88-122-119-54.rev.libertysurf.net [88.122.119.54])
        by mx.google.com with ESMTPS id 28sm4830441eyg.22.2009.11.08.17.24.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 17:24:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4AF7502A.9020903@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132435>

The 09/11/09, Maximilien Noal wrote:

> Why not put the translation first, then the english word between () ?
> At least for English words above that are not used by French devs "as  
> is" (not like "diff") ?

Because it would decrease the readability. The () tip can't be used
everywhere seriously.

> That way, newbies to SCMs' concepts get the idea, and old SCM users  
> don't have to translate back.

Newbies learning Git's concepts have more interest to learn the english
words too ; the GUIs should help them to do so. Matthieu Moy explained
why very well in this thread.

-- 
Nicolas Sebrecht
