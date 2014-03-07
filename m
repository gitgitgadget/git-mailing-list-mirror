From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] commit.c: Replace starts_with() with skip_prefix()
Date: Fri, 7 Mar 2014 18:09:19 +0530
Message-ID: <CAOLa=ZQZOxEzXUEwCVpesNzRhJ5_sMbtbUpaYjdfEOOrakbG0Q@mail.gmail.com>
References: <1394125521-9341-1-git-send-email-karthik.188@gmail.com> <CAPig+cR0tw4em_mPNLdp1-gNER2G1FyAVCyZAb9_TbtSyuGyaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 13:39:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLu41-0008TH-Ru
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 13:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbaCGMjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 07:39:40 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50970 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbaCGMjk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 07:39:40 -0500
Received: by mail-pa0-f53.google.com with SMTP id ld10so4088810pab.26
        for <git@vger.kernel.org>; Fri, 07 Mar 2014 04:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=E0JfpuvixVWmaozwYIGuJEKgJxfr50Kd+0U+TpHi7N0=;
        b=ymqpNv0MGgusj8tlGGw2wIcilW2NfCv5zyDBaItitYaFDGfmqwCTaRt/AlEPXbBf2K
         F3vmoc/MjGbokpMkRLZiLk3AVqCW55qG6H9VD86obDtrfptfujdGOje9iIpc25+yGOaA
         J168BH7tP4lB0vfrM7Rx20PyPklDGZ0dBUgy8ldtGXQ33KtaWsh7Cdp7i+WRtEWk4Suk
         HoarpgBt8ZsD8DDnC8pOrw1tF/WHGw1GvWoNtLgOygMaGr539qoWy+Wo7UsL1EQjDvk6
         3ww8JMHDwK47sAUmUDKk+VtWHYSbJ3zA0nKoYhYk8hKLK2G4WU+I8JJDwih4cOgBj323
         pijQ==
X-Received: by 10.68.237.133 with SMTP id vc5mr21784040pbc.92.1394195979715;
 Fri, 07 Mar 2014 04:39:39 -0800 (PST)
Received: by 10.68.138.138 with HTTP; Fri, 7 Mar 2014 04:39:19 -0800 (PST)
In-Reply-To: <CAPig+cR0tw4em_mPNLdp1-gNER2G1FyAVCyZAb9_TbtSyuGyaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243612>

Hello Eric,
Thanks for your reply, and for that information.  should i patch again
or this should do?
And what next? Talk to the mentor?
Thanks
