From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/36] Massive improvents to rebase and cherry-pick
Date: Sun, 9 Jun 2013 14:37:44 -0500
Message-ID: <CAMP44s2nbo97qFenwm3RaHYQ4K14knZpSvpLPPM3uPiFSRinuQ@mail.gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:37:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllR0-00006G-K4
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459Ab3FIThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:37:46 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:58731 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab3FIThp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:37:45 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so5680700lbh.35
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Yx0Ohj849Xh1/bQz1UP84Icfk//MIMG2iWjZ7ZlvdUQ=;
        b=JRLuhzh646iEnvbK3PwP3nA5IfIhM4VUJC1K6taeR/aqFBsoEMXwL/GjoqC3HNiwx2
         FLTPaT4H1QtX1Dd/segZ1P9S9lYAK/oBFwjIbK/Cndy5A6dt861RaOmNz6MJp8gm0xYh
         ZuAfrSlKcRLI8KATSXLuY/sojhIzbqaN+oIjvNJh23ORja6loOOiotzGdw0alq9gnMAy
         GBmfI+WIPZBFhm0NHwdm27WIgdBjNnnyO8Slw/lJqde3LtE4kol7Hog6vmdDur+1A6f+
         5zMYYTU9AXmtrJ17SwoMHG9Dhha7jz+hg4P23Ft+HDKbxUncjnyuYj0Jr57XEOo0VhGA
         MBrg==
X-Received: by 10.152.43.136 with SMTP id w8mr3446584lal.63.1370806664305;
 Sun, 09 Jun 2013 12:37:44 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 12:37:44 -0700 (PDT)
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227150>

On Sun, Jun 9, 2013 at 2:24 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Same as before, but:

Also, remove the patches from Martin von Zweigbergk, because
apparently some people have trouble understanding that they were not
part of this series.

-- 
Felipe Contreras
