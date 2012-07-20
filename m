From: Thiago Farina <tfransosi@gmail.com>
Subject: ninja build
Date: Fri, 20 Jul 2012 12:42:33 -0300
Message-ID: <CACnwZYc-AaVppw8RHwF4O4SSaNcEOtJkyM0iOMAVGTo6kSjJsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 17:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsFLj-0007td-6s
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 17:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab2GTPme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 11:42:34 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:32864 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab2GTPme (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 11:42:34 -0400
Received: by gglu4 with SMTP id u4so4106791ggl.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7IqJ0sZEi7yWMp3oxQBRQlPceTENIy9LNOkNPmfdaLQ=;
        b=rON9oUs/tx96gFSBaJVyErSGYjjmLuf23//eNNud7ACrXBR9jfD1qeNfv9IiuadZ2i
         cEtjiy18G0cOaH+1rZjVImCi1ANHJ2YKH/VR07CYZQ3K65hv5PzyCl/RyFM1DNEePbM7
         pVRg7/M5tcemQGs5rm6jDu6c9fpZ7Pz6XzI/QRbx6tz0go10Nu/fwkQn2U2qVf2JdOOp
         z4kKOOql4+V4ynd23UOLqHeYJW7nKM8HmnkyME2AvVtD10x6Svks5ZQ+PkvjTEHuhm+6
         3vvK5G7bG0gqic/TzfOYz1u/eYDUn9IvvUXQF6mZz+hpnYMes0YfEzBAi0QR0ERwtoOf
         2ZBw==
Received: by 10.60.30.35 with SMTP id p3mr7716963oeh.16.1342798953244; Fri, 20
 Jul 2012 08:42:33 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Fri, 20 Jul 2012 08:42:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201774>

Is there any interest in building git with ninja? [1]. I think it
would be very interesting to move forward from make to ninja.

[1] http://martine.github.com/ninja/
