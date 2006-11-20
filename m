X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Patch to tutorial.txt
Date: Mon, 20 Nov 2006 10:34:42 +0100
Message-ID: <4d8e3fd30611200134u33ee3a83mfce7c4da89d630d4@mail.gmail.com>
References: <4d8e3fd30611191444r710f23e5uc488d35aa4abaf06@mail.gmail.com>
	 <200611200949.32722.jnareb@gmail.com>
	 <4d8e3fd30611200110y224b5b8dpf974d30d738455c9@mail.gmail.com>
	 <200611201025.11048.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 20 Nov 2006 09:34:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dw9qoP4N3YUfhzG2UJtAJe+Vmz00GmU/Zora2taMb8RKhGm9L41Xji/KzXITbqJzCZq205pixYzIy85z0PVrpL7ysteuXhWBiNfeOXF/eqeRhTqiYppb+OPV7OvfqulRpA4tSHLGfSR72uetK/PleijR7jtSAHm2UoYJXZ9aw+E=
In-Reply-To: <200611201025.11048.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31889>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm5YC-0007GT-9D for gcvg-git@gmane.org; Mon, 20 Nov
 2006 10:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933064AbWKTJep convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006 04:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933359AbWKTJep
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 04:34:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:13149 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S933064AbWKTJeo
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006
 04:34:44 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1125734ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 01:34:43 -0800 (PST)
Received: by 10.78.75.15 with SMTP id x15mr4956165hua.1164015282690; Mon, 20
 Nov 2006 01:34:42 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Mon, 20 Nov 2006 01:34:42 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/20/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Paolo Ciarrocchi wrote:
> > On 11/20/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> >> followed by empty line, then signoff line, for example
> >>
> >>   Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> >
> > Ok, but the Signed/off-by part should handled by the -s option in
> > git-format-patch.
>
> Signed-off-by _can_ be added by -s option in git-format-patch, but
> I think it is usually better to have it added in the commit, by the -=
s
> option to git-commit.

Oh, I wan not aware of that as well. Maybe it's worth to be mentioned
in the tutorial.

I'll properly redo the patch later today or tomorrow.

Thanks!
Ciao,
--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
