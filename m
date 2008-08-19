From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 14:53:09 +0600
Message-ID: <7bfdc29a0808190153o3d3b2635v4276ef4fa65fbb8@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	 <48AA7BE9.4040108@sneakemail.com>
	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
	 <7bfdc29a0808190110nddaf57fw5bf40903f3072bff@mail.gmail.com>
	 <48AA83B4.2080009@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:54:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMyl-0007zM-2G
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbYHSIxM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 04:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYHSIxM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:53:12 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:4983 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbYHSIxL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 04:53:11 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1415355yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 01:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fVnQCKLnpIGLW/uJwZOzMiNjP7T6QcL1ihzeyARkRr4=;
        b=IYrWlDMzK4b1lYEtc/+lX8LxfwAx8SrQ01ygrZ6OwzpFn82ZFwUUuVr5e9HTjUAd9q
         Jdcp4r6Bu5zVHxBHZxY4Z+69vqEBSAau2TyyjGHmqFTGIaEB/sJutOrct+pEl1i5NG6v
         9thWNgO0tATUv2LyFwWGOXWUpCBs5yz4vpO2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=up2+7wKMUhwRXR59TthgpNH2NOICqWgsbXBE9KHt5fVnpK3gzdv6gfWxcKpPPlScay
         Q3x5b1X36SQD6rZ8gC8b8tt4G01XVwggE007gkOO+U9IBgw8h/6qE4aBNLuP+rRrc2xO
         olIphB6aF87ifum7Q8TEzGaNI4oQpuFFxeOSI=
Received: by 10.150.219.18 with SMTP id r18mr6653781ybg.113.1219135989378;
        Tue, 19 Aug 2008 01:53:09 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Tue, 19 Aug 2008 01:53:09 -0700 (PDT)
In-Reply-To: <48AA83B4.2080009@sneakemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92835>

On Tue, Aug 19, 2008 at 2:26 PM, "Peter Valdemar M=F8rch (Lists)"
<4ux6as402@sneakemail.com> wrote:
> Hi,
>
> Imran M Yousuf imyousuf-at-gmail.com |Lists| wrote:
>>
>> I would not agree it to be a part of git-add man page, but rather it
>> should be a part of doc that explains basic git commands and their
>> flows. I feel that we need a place where git flows are explained. IM=
O,
>> gitwiki is a great place for it. I would like to volunteer to add
>> these pages to Wiki.
>
> Why not? Shouldn't the man pages be a superset of those other docs?
>
> Does it seem clear to you from reading "git help reset" that it is re=
lated
> to "git add" and that one can undo a git add with git reset?

Actually when I learned git I never learned one command after another,
rather I learned the flows and the most the scenarios mentioned in
this thread mostly got covered then in either first or second flow I
was trying. What learning flows enabled was, for me to experience how
commands are inter-related.

It basically depends how a person learns the tool. My way of learning
a tool is to learn flows. I have also taken the same steps to teach
some of my friends and colleagues git and all seem to understand the
stuffs :). But hey, that is my opinion :) only.

Best regards,

Imran

>
> Peter
> --
> Peter Valdemar M=F8rch
> http://www.morch.com
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
