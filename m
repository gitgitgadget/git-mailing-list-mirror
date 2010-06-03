From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-quiltimport
Date: Thu, 3 Jun 2010 14:03:12 +0200
Message-ID: <AANLkTil4kRT8mwZ3i80sKRGzUKAgBcp1cqGHg8dcfBkQ@mail.gmail.com>
References: <4C0795B3.1070602@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ebiederm@lnxi.com
To: Ian Molton <ian.molton@collabora.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 03 14:03:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK999-0005l7-8R
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 14:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398Ab0FCMDe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 08:03:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37447 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab0FCMDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 08:03:33 -0400
Received: by gwaa12 with SMTP id a12so5430972gwa.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 05:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tLzjkyDymtFoNEzxKtqghsr2WbfWDZgF3q0zI3qxiic=;
        b=gmOh3ymPpm59pAfYy07nzuWAY2LWvjRDJHRpv1I2MpM4Yiso3e3XT7oyPFp0PI7A1+
         1HFWjPzAiI+2PYXoxE7OeHx8Uj0g89t6ys3VZJ3dFO/7HG9OLTizTyBOLPbmeiW0HkwK
         xBulWMzbkIST6MuUEgd1jzNxgzbj/ZdfDzSv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QMt3JYFJw10XLGYa5KhUPw2sJaT6CQw+Z/9LKfdiqMOa0qOpxF66bZhky2RSAbr51G
         YB3OZ0ofo11WtPKkFgLV8bVwOiQzlc6EOFXSSr0hTA4jOrogDKcdZEp6ID6BKik1fl14
         h1YkCtlYf6vV/20+grJ6Bx4xtNZEFzYYTSqxI=
Received: by 10.224.78.131 with SMTP id l3mr4515162qak.277.1275566612171; Thu, 
	03 Jun 2010 05:03:32 -0700 (PDT)
Received: by 10.229.43.5 with HTTP; Thu, 3 Jun 2010 05:03:12 -0700 (PDT)
In-Reply-To: <4C0795B3.1070602@collabora.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148313>

Hi,

Ian Molton <ian.molton@collabora.co.uk> wrote:
> I've written a little patch to git-quiltimport that helps it with som=
e stupid
> =C2=A0quilt repos.

Didn't you already send this yesterday? Are there any differences?
Also, please read and follow Documentation/SubmittingPatches in
git.git so your patch gets a wider audience.

-- Ram
