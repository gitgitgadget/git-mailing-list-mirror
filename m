From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] po/hi.po: Eliminate fuzzy translations
Date: Thu, 7 Jul 2011 13:58:33 +0200
Message-ID: <CACBZZX6M0PwxqT8HuvU4eMn+9P_wg2H+tLGTQhMXP-znhWJ-5w@mail.gmail.com>
References: <CACBZZX4dP-OsrZ3wBOeSkzDFy6XBgeY=eqJUF2acyLC8W-3Vpg@mail.gmail.com>
	<1310019016-2581-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 13:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QenE7-0008WT-I1
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 13:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab1GGL6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 07:58:35 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:55459 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab1GGL6e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 07:58:34 -0400
Received: by fxd18 with SMTP id 18so1021222fxd.11
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2+d2AejfYgQk+dt8lm1fJKn3GGpi0tb48N2MVFj7I3w=;
        b=byRrWtjVvyLmKGz8oOMLMqliu5/+5NdKurFrZYeuzh0yUVMGpOJ+oib3cKAys4OKKW
         ln/cPzfSPPa0Mtv8PzZECs/kec6EMgyF5i+z6pny2WBl75LToCqduKjpVLenN+2WKGlr
         xyx1ulwDqLpJWOeSKG/1Fx6byIMeSfooHvQr0=
Received: by 10.223.32.142 with SMTP id c14mr1120750fad.59.1310039913198; Thu,
 07 Jul 2011 04:58:33 -0700 (PDT)
Received: by 10.223.114.208 with HTTP; Thu, 7 Jul 2011 04:58:33 -0700 (PDT)
In-Reply-To: <1310019016-2581-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176759>

On Thu, Jul 7, 2011 at 08:10, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Remove all fuzzy translations by either correcting them where trivial,
> or removing them altogether.

Thanks. Will incorporate this into the po patch series.
