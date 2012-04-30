From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Glossary for bootstrapping Git translations
Date: Mon, 30 Apr 2012 16:20:48 +0200
Message-ID: <CACBZZX57-=fM+wVrFhooBB4wrbUBT1WXdb5NYXK6Lv=zEMLNKQ@mail.gmail.com>
References: <CACBZZX7H8qB05qc+ovaeFJ_qR3bF7=uWq6bjOHq8+_YNDLTu2g@mail.gmail.com>
 <CACsJy8C6QLYz1fks=r7KbvS80x=x7ZpzfE3ACGOv1S3YEPH4qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Hinrik_=C3=96rn_Sigur=C3=B0sson?= <hinrik.sig@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Xin Jiang <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 16:21:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOrTa-0006fp-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 16:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710Ab2D3OVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 10:21:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61845 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab2D3OVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 10:21:13 -0400
Received: by eaaq12 with SMTP id q12so702239eaa.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cQlaJtxryclCGBPcnd69SibyT0ttAx1nBDWJlTQ6frw=;
        b=kEHE9YOk7WgxbECbGgdu5FqlfcsqcenwUsmpKqgeBxsJfA5o7Ev2Jxul5gHs6gBWze
         fjpEcnZPrBJOAZ3YwTM5AUEKLVIpwTmXhhOBRTh25G6OLDtP/Gb5GdW3hZ7s43VkuWVD
         u6hwdTk40t591wsI11604N8gEyAxAYAgqbudy1+BRUp/spkVXfPxVLKDBDNGEFKnFp9w
         +M97aNq++yRByoAfpBgsPN7P6Ko31ORaf1fBCPMBWGTpSZ6x9er6RAJU55vQRsRdf5sw
         5NpCt9MoRncKSCIdL076sN174uFq9oTE6WaihQ0qSVfaBkfWYEs1PbEE4dz5Am6OBGIw
         jblg==
Received: by 10.213.3.153 with SMTP id 25mr1532729ebn.86.1335795668711; Mon,
 30 Apr 2012 07:21:08 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Mon, 30 Apr 2012 07:20:48 -0700 (PDT)
In-Reply-To: <CACsJy8C6QLYz1fks=r7KbvS80x=x7ZpzfE3ACGOv1S3YEPH4qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196560>

On Mon, Apr 30, 2012 at 13:29, Nguyen Thai Ngoc Duy <pclouds@gmail.com>=
 wrote:
> 2012/4/30 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
>> I think having something like this in po/GLOSSARY or in a similar
>> location would be very useful to get new translators started. I'm
>> CC-ing the other translation leads so they can look the English core
>> terms I've come up with over, and suggest new ones.
>
> Just checking. Have you looked at Documentation/glossary-content.txt?
> That and this glossary may not be exactly the same, but you should be
> able to copy some terms from there (e.g. pathspec), or even add some
> back.

I hadn't seen it recently. I think I'll incorporate some things from it=
=2E

In practice translators don't have to worry about many of those terms,
so I think there's some value in having another document for terms
they need to get straight to get a translation started.
