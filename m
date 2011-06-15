From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: no autocrlf on Visual Studio subdirectory
Date: Wed, 15 Jun 2011 14:52:58 +0100
Message-ID: <BANLkTikbnKNHxt5wKDjUWYby+p3w0cHcgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 15 15:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWqXH-0002Hc-31
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 15:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab1FONxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 09:53:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38719 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab1FONxT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 09:53:19 -0400
Received: by ewy4 with SMTP id 4so169535ewy.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 06:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=+QhEIl7ehCiAl3/W8vipcQpfWIYdz7ztsPKtPyABNdM=;
        b=UnFFisiHiinO7F56fHm0mmsA0CejHsu7Te0Aew70GDRbh/j8WKOJbZkDinij6Nrgq/
         3VTC8oHq/JN3cc16OxqdaZc5Pypk9rJJXTqvThC+XC7WntrYQ9897M9G6NYC/idSYfti
         rU8xKaXTY8kSqACDyUvXTbxTlcvcbCSKP8IKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=aykVxNrdRsnyPqptUTvn+Nhh7ki8TcwrBoJ1lDZTFSwKcgVe6AegHtLJOZhmjmCqji
         FljQrkBYhrVOJF15Zyrkzbhgex4q8f6u7I9Qz1F/VaLZoEk2ZLzsULkUkhZOIYDPcpxa
         kv5us4yaBxBUKgFGBxOGyPi63t1eojgIhy8h8=
Received: by 10.14.189.4 with SMTP id b4mr282966een.144.1308145998235; Wed, 15
 Jun 2011 06:53:18 -0700 (PDT)
Received: by 10.14.127.70 with HTTP; Wed, 15 Jun 2011 06:52:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175831>

Hi,

I am wondering if there is a way of keeping CRLF's under my
VisualStudio2010 subdirectory but applying core.autocrlf on all other
repository directories.

Many thanks in advance,

Aaron
