From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: gitview: Set the default width of graph cell
Date: Wed, 1 Mar 2006 12:45:30 +0530
Message-ID: <cc723f590602282315q7ffac2bbub8a1ee32ee123963@mail.gmail.com>
References: <440460DC.7080307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11300_10743354.1141197330278"
X-From: git-owner@vger.kernel.org Wed Mar 01 08:15:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FELYd-0005a5-3g
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 08:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWCAHPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 02:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWCAHPc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 02:15:32 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:54508 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932583AbWCAHPb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 02:15:31 -0500
Received: by uproxy.gmail.com with SMTP id j40so28984ugd
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 23:15:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=WlCtaMLfxeFDlT1wOQWbyoTwJ6jUPOmVm5s91VZ9kSDHTpxR/Vo6mVXMJU4rPxXOlgoTRMb1B9FhdMbnZfVC6eh+NUhgL6hPkqqs7mJ+fg3tZFDvKndz08KwR/pBtjNZt8ivMH+SzTm15kWaxxkltwSak/fWi6MH4g9TWMQ3wXI=
Received: by 10.67.91.6 with SMTP id t6mr811017ugl;
        Tue, 28 Feb 2006 23:15:30 -0800 (PST)
Received: by 10.66.254.7 with HTTP; Tue, 28 Feb 2006 23:15:30 -0800 (PST)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <440460DC.7080307@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16964>

------=_Part_11300_10743354.1141197330278
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2/28/06, Aneesh Kumar K.V <aneesh.kumar@gmail.com> wrote:
>
>
> Subject: gitview: Set the default width  of graph cell
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
>
> ---
>

I guess this one is better. Please apply this one . This is on top of
the previous one.

-aneesh

------=_Part_11300_10743354.1141197330278
Content-Type: text/x-patch; name="git.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="git.diff"
X-Attachment-Id: f_ek9bf04n

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvZ2l0dmlldy9naXR2aWV3IGIvY29udHJpYi9naXR2aWV3L2dp
dHZpZXcKaW5kZXggZWEwNWNkNC4uZGU5ZjNmMyAxMDA3NTUKLS0tIGEvY29udHJpYi9naXR2aWV3
L2dpdHZpZXcKKysrIGIvY29udHJpYi9naXR2aWV3L2dpdHZpZXcKQEAgLTUxMyw3ICs1MTMsNyBA
QCBjbGFzcyBHaXRWaWV3OgogCiAKIAkJc2Nyb2xsd2luID0gZ3RrLlNjcm9sbGVkV2luZG93KCkK
LQkJc2Nyb2xsd2luLnNldF9wb2xpY3koZ3RrLlBPTElDWV9ORVZFUiwgZ3RrLlBPTElDWV9BVVRP
TUFUSUMpCisJCXNjcm9sbHdpbi5zZXRfcG9saWN5KGd0ay5QT0xJQ1lfQVVUT01BVElDLCBndGsu
UE9MSUNZX0FVVE9NQVRJQykKIAkJc2Nyb2xsd2luLnNldF9zaGFkb3dfdHlwZShndGsuU0hBRE9X
X0lOKQogCQl2Ym94LnBhY2tfc3RhcnQoc2Nyb2xsd2luLCBleHBhbmQ9VHJ1ZSwgZmlsbD1UcnVl
KQogCQlzY3JvbGx3aW4uc2hvdygpCkBAIC01MjYsOSArNTI2LDYgQEAgY2xhc3MgR2l0VmlldzoK
IAkJc2VsZi50cmVldmlldy5zaG93KCkKIAogCQljZWxsID0gQ2VsbFJlbmRlcmVyR3JhcGgoKQot
CQkjICBTZXQgdGhlIGRlZmF1bHQgd2lkdGggdG8gMjY1Ci0JCSMgIFRoaXMgbWFrZSBzdXJlIHRo
YXQgd2UgaGF2ZSBuaWNlIGRpc3BsYXkgd2l0aCBsYXJnZSB0YWcgbmFtZXMKLQkJY2VsbC5zZXRf
cHJvcGVydHkoIndpZHRoIiwgMjY1KQogCQljb2x1bW4gPSBndGsuVHJlZVZpZXdDb2x1bW4oKQog
CQljb2x1bW4uc2V0X3Jlc2l6YWJsZShUcnVlKQogCQljb2x1bW4ucGFja19zdGFydChjZWxsLCBl
eHBhbmQ9VHJ1ZSkK
------=_Part_11300_10743354.1141197330278--
