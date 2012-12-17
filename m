From: Chris Rorvick <chris@rorvick.com>
Subject: Re: How to specify remote branch correctly
Date: Mon, 17 Dec 2012 00:44:36 -0600
Message-ID: <CAEUsAPY3rbwrN48v5oM1OsA9ftaaWPQC69XO75ug=Ev55N7NEg@mail.gmail.com>
References: <slrnkct0r3.dsp.narkewoody@zuhnb712.local.com>
	<CAH5451=7frqa-YHXubvO=dMK2CvVoWR-VFZ3XCmKouNiQz4gAg@mail.gmail.com>
	<slrnkcta0j.mlu.narkewoody@zuhnb712.local.com>
	<CAH5451kmTW+nO4V4pjSdaqhHAb=RX-tawLo=rJfuPnDRDWeSEA@mail.gmail.com>
	<1355722245-ner-6603@calvin>
	<CAH5451=KX5eZH6AUoaQ7YcWcNcKhUp8Lk8Uvs3o=jWW=vaYiCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 07:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkURc-0002IS-7s
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 07:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857Ab2LQGoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 01:44:39 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:36358 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab2LQGoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 01:44:38 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so4386788lag.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 22:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=L0FKF4HqbPT2yHtjL5Ia7RwnpzHLu+skbT1ElZL/mhw=;
        b=yWIY4fV8VvaxNsha6CjE+CJoxwLb8sndRJX787H7aauscWkVaXapOKq9WbeQTr46Wh
         cQ5EyTOA+k2rBUXKOD8FFeDLZJn2GL/UoybiCo6/h+ErqzjEI0I3jZGA7RCcD8/KN8+a
         Ou21M+242WeqKNVebZvA4ZmLOgDHawwLr8kVV4o+H57Fso9JNT1jYzWL7X+zGc2nD8KT
         LYPTldYtxocv5TLb/lajFWRweG4Fs5u+eGCuzQWIc7cUVSrduUi7u7Jtdz2NIcI/mSjH
         Co2EAxW5nId/tbph9lwFBdUVj91/Oh5ms8L2L22pAmGGQSXkauy3T+5OPP+MnlzoQD6V
         sAvQ==
Received: by 10.152.148.129 with SMTP id ts1mr9946815lab.19.1355726676711;
 Sun, 16 Dec 2012 22:44:36 -0800 (PST)
Received: by 10.114.94.131 with HTTP; Sun, 16 Dec 2012 22:44:36 -0800 (PST)
In-Reply-To: <CAH5451=KX5eZH6AUoaQ7YcWcNcKhUp8Lk8Uvs3o=jWW=vaYiCg@mail.gmail.com>
X-Google-Sender-Auth: 9posAwRyN1tatFGI7LD49MsFSlw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211635>

On Sun, Dec 16, 2012 at 11:52 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:
> This is true, but I don't think it is documented.

I noticed this, too.  I was just about to send a patch to add this.

Chris
