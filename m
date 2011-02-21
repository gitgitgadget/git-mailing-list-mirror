From: xzer <xiaozhu@gmail.com>
Subject: how a patch can be accepted?
Date: Mon, 21 Feb 2011 23:48:41 +0900
Message-ID: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 21 15:48:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrX4B-0004t1-An
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 15:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756001Ab1BUOsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 09:48:42 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45686 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755814Ab1BUOsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 09:48:42 -0500
Received: by iwn8 with SMTP id 8so1961391iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 06:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=DCNGQQRHtx0HIZTgSnBanuDLnKGri0dBrptTg+0hTB4=;
        b=xZ4CVNS1jYGnmfv2b6/0rhydewlJxGkuoGtFuDCQ6Pqt4d8VA1Ku5xbUfqRMaY0uAI
         1Z7Rhl0ekAcfiKWBPRaulshbPaOUiKX+yikM98mi8LG7zO3vOFR0Ened9cQvk7ib8rau
         b4dEzlgQlnDC4vU1gSIcmglHsN5WucxLz0OWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tZBpymZ/dpwWPpZv2Q2EnW55nnCw1aURfqGz1HnjKmxGYb5hGYFM6qBwxDFJqNazSC
         8drFUndZMcf0t1lktO/aYIvfZHf0cjMWZYDGhth3IuJPWidfG41EkuKEXhhxNIYWeE7u
         tqnwb59OOsvkYrneg+mrl6Jnlf13ZbHABt6os=
Received: by 10.42.153.133 with SMTP id m5mr1117158icw.332.1298299721391; Mon,
 21 Feb 2011 06:48:41 -0800 (PST)
Received: by 10.231.35.3 with HTTP; Mon, 21 Feb 2011 06:48:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167483>

Hi,

I submitted a patch recently by sending a mail to this mail list, but
I don't know how it can be accepted or rejected? Is that enough just
send a mail to here? Because the patch is a very important fix to my
usage and I don't want to apply it every time by myself.

Best Regards
yours xzer
