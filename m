From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Dead link
Date: Sun, 21 Jul 2013 01:00:11 +0530
Message-ID: <CALkWK0ktWTcgNSjTtkjJ5ogjE5YAVRdq+HZpQ51-DFObsCjQrQ@mail.gmail.com>
References: <20130720192238.GA30833@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Sat Jul 20 21:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0cs6-0000u0-Ia
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 21:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab3GTTax convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 15:30:53 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:60588 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab3GTTaw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jul 2013 15:30:52 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so11940013ief.40
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rCQRv6xqfz/iAq8qyBX/SuxLoYPbWCm+yu8pbWlwB0g=;
        b=p2fgw79EfolVUKZfWQnmDTjhzS5S8cJF9Fcx8V0bo47prFc4S24YO2eynPfMwiV62P
         FM7Zv1OApX1eb/ALsLKcWrdRCcofvvByvl/hkDtkWVDyzuHpyrlFRIRmIIY704b5tlph
         hEuOvjtdWlK8BRUAaIS1pvC2eDq7wgANGllOlKJE6NXM8ftpUlC9mi1H63/PhctN692W
         ennDDciF76nwSozb5WB5P6ZWea5DWUulFK/prqVnv+ZKco6a+1xOzyROqNu0G7z5/4GM
         5ghFJQaNXphm6gf6sBBqj9GL7r2aHz1d5kHikH4qCaYvUxiBiePHYRR6tDtxJD0UWfJ1
         ARBA==
X-Received: by 10.50.225.66 with SMTP id ri2mr6161674igc.55.1374348651993;
 Sat, 20 Jul 2013 12:30:51 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 20 Jul 2013 12:30:11 -0700 (PDT)
In-Reply-To: <20130720192238.GA30833@domone>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230904>

Ond=C5=99ej B=C3=ADlka wrote:
> http://marc.theaimsgroup.com/?l=3Dgit&m=3D112927316408690&w=3D2

Just run a sed 's|http://marc.theaimsgroup.com|http://marc.info|', and
submit the resulting patch.
