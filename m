From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: .gitignore: according to what rules does this work - SOLVED
Date: Thu, 27 May 2010 11:10:13 +0200
Message-ID: <AANLkTim3HnyPK9D9dy-dMjm4UGtHZrQJGCWtVV39JS9G@mail.gmail.com>
References: <-8502405260163699034@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konrad Karl <kk_konrad@gmx.at>
X-From: git-owner@vger.kernel.org Thu May 27 11:10:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHZ6u-000056-22
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 11:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861Ab0E0JKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 05:10:35 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:64856 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab0E0JKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 05:10:34 -0400
Received: by qyk13 with SMTP id 13so10618864qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 02:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=80QoYhKe+QxHJmtvJcCx/iZQ1zAXp1YSZxLwm9tVx7M=;
        b=VVn7WeoGJAWB4zDXVwTBB3XEs1r4NszE6fBOMgkPJOXoNw0mORcTgDGN9nA6chnc9+
         OFDYDmw1BOxWcP+f0WjdFJWkFApTzfCtaSbWHX37ntu5VInq38/2tMOho6HD89iOb1ET
         5gvjODiR7dpwjUDq00en/oEvnrZOUl5psIJwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VCioc9jJHBRsJChxUN6vxrTtue0NJx6aSLHui5SizSRvUp9d5CF2KJHT9DGemZFxmc
         u80xmsxeRWzPTdHlPFnf0bzJQvuVcZg++oFTCIO53l+2axwixhH6oM7zIwgClhSm0chL
         KWZOtlvFDtQ3mAO2V83VKUEOLjjlS79jas4sk=
Received: by 10.229.212.133 with SMTP id gs5mr2150635qcb.89.1274951433106; 
	Thu, 27 May 2010 02:10:33 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Thu, 27 May 2010 02:10:13 -0700 (PDT)
In-Reply-To: <-8502405260163699034@unknownmsgid>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147840>

Hi,

On Thu, May 27, 2010 at 10:51 AM, Konrad Karl <kk_konrad@gmx.at> wrote:
> There was a trailing blank after the first
> asterisk. When trying =C2=A0with two asterisks in despair
> I started with a fresh file with no trailing blank.

Quick tip: ask your editor. When in doubt, I use whitespace-mode in Ema=
cs.

-- Ram
