From: Eric Schaefer <eric.schaefer@ericschaefer.org>
Subject: Lowlevel documentation
Date: Sun, 23 Aug 2009 12:04:44 +0200
Message-ID: <34f8975d0908230304k41ea18b4xf57bdb3099ddfced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 23 12:05:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf9xK-00085u-S7
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 12:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbZHWKEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 06:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755975AbZHWKEq
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 06:04:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:25079 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971AbZHWKEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 06:04:45 -0400
Received: by ey-out-2122.google.com with SMTP id 22so438511eye.37
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=VgOGsqqjsvjPazluvH7PzVF61A+EskN4jzxuGcKPpZ0=;
        b=ugB22KMrtFzo7GjJMhtwOKHgQgSvye/LoBX+RyzQEgIzwnOnmv0B3LzuZB/C3W/Rnm
         nE25wbGPQIt2t23PxfXd3SaQM2loqvAjiIXIoxhHX+B41vuEWvvH1t0XjIYF7Gc/Ts3E
         G7fy7z5cAvKe/zeU51pt6yN5ra3N+uku4P4No=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=t37b2y/lSm+TIBjvqUXMmGuZpaNjL7E6Tk9AJTR13MnkVIpX3gIC0usmXF03bOOtvH
         1z9A+gMtrn/BW8aX+EljR2zU5u0c729TlVRlARX8OfKGob15upAnM0gf7RLFMbSSnASB
         fsN9+pceVUHEWxveU+gdEVK9wL5DXI59S8COE=
Received: by 10.216.11.67 with SMTP id 45mr688776wew.53.1251021884900; Sun, 23 
	Aug 2009 03:04:44 -0700 (PDT)
X-Google-Sender-Auth: 2028f07d5172bc30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126851>

Hi,

a couple of week ago I read a blog post, a paper or an article about
how a simple scm could be designed step by step and how this would
become git in the end. It explained really nicely how things in git
work and why. Does anybody know which document I am talking about? I
can't find it anymore...

Thanks,
Eric
