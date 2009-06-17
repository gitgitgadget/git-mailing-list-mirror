From: Frank Li <lznuaa@gmail.com>
Subject: git format-patch
Date: Wed, 17 Jun 2009 22:03:54 +0800
Message-ID: <1976ea660906170703k1f17301gcbae4a8bc8805014@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 16:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGvkB-00054O-O6
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 16:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbZFQODy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 10:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755150AbZFQODx
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 10:03:53 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:7186 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbZFQODw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 10:03:52 -0400
Received: by wa-out-1112.google.com with SMTP id j5so85710wah.21
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=uyjupP+W0pL1KiNa8+KqDBsE7PfR74PqIVk5S9sJ/+o=;
        b=YOmctmzknl25Z5urKj1P8cWCsU+zByl5qaBoB5jKc67i+a3BR7qvF1ISXwf/NSZaJR
         zdndfZ4S7WIBw8kScUBl23iwSmth+0K5IV5aErAqc798rzQ0Ij2tlpBpav4QKIaGocen
         3R2rjGqUtZE65q9FNFdAyR3B06tAbUqfe/WJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=VaMMz85YvpHMnIrLE4uVAHFZWtrlGhSr/YfM69z7tt3EuT+LC9zTPpZBTViV5okVaT
         ygaaJUj9A2B2vOEFjiIFfx6HisvC3Gw7KW8TPKWmhoAfuGYwUomHaVO5D8YYesqsPSCZ
         hCsv6YaCD6Dg0Gtbglsambe6hjBXUvm9t/O4M=
Received: by 10.114.25.19 with SMTP id 19mr271900way.89.1245247434905; Wed, 17 
	Jun 2009 07:03:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121748>

git format-patch -4
only 3 patchs is created

git format-patch -5
4 patchs is created

I remember old git version -<n>, n patchs is created.

Does it expected?
