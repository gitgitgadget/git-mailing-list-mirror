From: Twiinz <twiinz@gmail.com>
Subject: Re: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Mon, 19 May 2008 12:34:31 +0700
Message-ID: <412a1d9a0805182234i18e2da4ckf428b2c134e174d1@mail.gmail.com>
References: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
	 <20080519040746.GA29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 19 07:36:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxy2H-00016r-V8
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 07:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYESFed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 01:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbYESFed
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 01:34:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:11315 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbYESFec (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 01:34:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1211427wfd.4
        for <git@vger.kernel.org>; Sun, 18 May 2008 22:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=2FUV8oV1bZB5RWwcda0hZxf1hM0rYX07HboQN1tbkSs=;
        b=ZDytAfGcVUa4ieNYdtTthdnPgtymcexTwlL1xa8yVQ/JeVOuFnwnhWgWByHv6n8n/8e4cwDoSJt0W4nBaRlmXVU3gxuKUG9ltXM8bHQvOfuC4fy/qREii1V10J2Dn4O0VtK07JYDB6ReTiV8yU77H6Af1Jo/wIU2AAU7yEbt4i0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=xMJpr0Qkbi3h00V6ajZ4B0Q+yqG2UCjBkdtfhkA3dJyHFXIRsPgFQpHfOJoLYu8O5XXyzBNm97sWIng1dRzX3/17GUl0ETDrLlbvTUziB90s3PZVZKl3WYsMcxUVuOD3F383O9k45QASPd6KRIKVL6KTFBqwNaXjTBY3KiT9er4=
Received: by 10.142.84.3 with SMTP id h3mr2670808wfb.34.1211175272035;
        Sun, 18 May 2008 22:34:32 -0700 (PDT)
Received: by 10.142.12.10 with HTTP; Sun, 18 May 2008 22:34:31 -0700 (PDT)
In-Reply-To: <20080519040746.GA29038@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: a8e63c6733e2070e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82413>

Hi Shawn,

No worries for Signed-off-by and "Twiinz <twiinz@gmail.com>" for the
attribution.

Sorry for the lack of information in the patch, I'm rather new to
that, I'll check out how to make it better for future contributions.

Cheers,
/twiinz

On Mon, May 19, 2008 at 11:07 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Twiinz <twiinz@gmail.com> wrote:
>> In git-gui after clicking either on 'Create New Repository' or 'Open
>> Existing Repository' the form elements aren't centered like they are
>> pretty much everywhere else in the app. At least when ran on a mac,
>> haven't checked on other platforms.
>>
>> Using grid instead of pack seems to fix this.
>
> Thanks.  This is a reasonable solution.  Signed-off-by tag?  Do you
> want the attribution to be just "Twiinz <twiinz@gmail.com>"?
>
> I ask because the patch is a valid patch and it does apply, but it
> isn't a standard git patch and wasn't sent inline, so git-am wasn't
> able to extract and apply everything for me automagically.
>
> --
> Shawn.
>
