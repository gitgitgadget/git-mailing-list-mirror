From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 65 new messages
Date: Mon, 06 Jul 2015 13:56:19 +0200
Message-ID: <EEB1332A-5D87-4D44-B3C6-9628E303EACB@gmail.com>
References: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com> <55992F6B.7040000@gmail.com> <CAN0XMOJXq6bM+9dpvrZgu7wd3iE93raFLReij1WCc1kkP=MYJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
	=?ISO-8859-1?Q?Magnus_G=F6rlitz?= <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 13:56:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC50g-000458-1d
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 13:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561AbbGFL4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 07:56:25 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34802 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbbGFL4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 07:56:24 -0400
Received: by wgqq4 with SMTP id q4so138218783wgq.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=oDmphh2HBsuGTE2/sU72ZaPuu/o5SrtW1kBKoZe4HMA=;
        b=WcCJDW4TcES/+4gJ28cJ1VyyebLjteNHn2qPSVb5Rvl1Ax3w9KtuPI+eYkVyFuckc3
         e0lsrpXL5wT5IJqGwykGRAsZQNDw6ZYAA9HS2B1mOL86AWm9Xx75wMQo2OD/jIx5CzKX
         nwSRIuNrlEB8+CC2WQwStXZC62geGYLEcYoQ6J0oXpWQqmNQj8fpuoYvFSORA/SYYT8O
         AglkqDfam9GWrTUkAO8S8vTaE8DR+3e2XQqD/5Ogoy2LQjFDuTrj1Zh255RvccJG9JxQ
         WcZqXbxsyUf0/N1Nssyr56NO5DhpnFnMLGONykjzDK2B/lsvTOimuH0oSxNO3iFOgqPq
         e87g==
X-Received: by 10.180.82.230 with SMTP id l6mr87203290wiy.61.1436183783639;
        Mon, 06 Jul 2015 04:56:23 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F453E8.versanet.de. [89.244.83.232])
        by mx.google.com with ESMTPSA id ei8sm27738211wjd.32.2015.07.06.04.56.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 04:56:22 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN0XMOJXq6bM+9dpvrZgu7wd3iE93raFLReij1WCc1kkP=MYJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273382>



Hi,

>This message is the title of a listing of git commands, that are
>available from $PATH but not located in git's exec path.
>
>Vorhandene Git-Kommandos in '/usr/libexec/git-core'
>
>  add                       merge-octopus
>...
>
>Vorhandene Git-Kommandos irgendwo in Ihrem $PATH
>
>  imerge
>...
>
>What about changing it to
>"Vorhandene Git-Kommandos anderswo in Ihrem $PATH"?

Yeah that's good.

Phillip
