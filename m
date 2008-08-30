From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] Debian packaging update
Date: Sat, 30 Aug 2008 23:33:01 +0100
Message-ID: <b0943d9e0808301533x7a652c59x1a227d6fa4a35961@mail.gmail.com>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
	 <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
	 <20080822235154.5e1f979c@whitehouse.id.au>
	 <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com>
	 <20080828140929.GB3584@khazad-dum.debian.net>
	 <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20080828205255.GA28644@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20080828222711.GB21850@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Daniel White" <daniel@whitehouse.id.au>, git@vger.kernel.org,
	stgit@packages.debian.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 00:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZZ1G-0007yX-Fq
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 00:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359AbYH3WdG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 18:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbYH3WdE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 18:33:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:7599 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755080AbYH3WdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 18:33:02 -0400
Received: by wa-out-1112.google.com with SMTP id j37so860225waf.23
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 15:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+Oo268dl/iS0kijMI2eJmcxCR1NBmrWdlvk8/C2pytk=;
        b=D8Ry9dgzUjJnCtw76nU52RC2SK714liLuN5bwvhohOpnUKq0sAntyItQ5w9ptTziP1
         qSdub9wMW6uefR2kmh8QUmCwgBOsNhVX0v6sbVAcHCwVzKkYKNjZOkfCDmSfScVIFJGM
         kfbxOGdCKQZ84Sp+NzDPqVwGw1j5jFFnLoa4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hYmq723WoNVu+sTATGOb7sp20O4RIBBxAsHDUOaeAuo31kvZhHZvagP1XyI/2KtTAp
         r8lDG0hMQhkChr/Bb1Fk/0I7HeQxI8DvErRCLdutbVOW4jqgRIZsGG0HsLS0fldsjfIz
         WqlCx6IiFbyIdvCMODxowUsblTwSyMcsdTT6o=
Received: by 10.114.73.14 with SMTP id v14mr3996214waa.163.1220135581684;
        Sat, 30 Aug 2008 15:33:01 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sat, 30 Aug 2008 15:33:01 -0700 (PDT)
In-Reply-To: <20080828222711.GB21850@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94442>

2008/8/28 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-08-28 22:52:55 +0200, Yann Dirson wrote:
>
>> The official package ships a copy of documentation pages from the
>> wiki, because they contain information not otherwise available. Do
>> we want to keep a copy of these files in the official repo ?
>
> We discussed this a while back, and i believe we agreed that having
> the primary copy in the StGit tree is a good idea. So, yes.

Yes, indeed. And it's on my plan to tidy up and improve the
documentation (though I wasn't that active recently either :-(  ). The
generated html docs could be put on the web somewhere.

--=20
Catalin
