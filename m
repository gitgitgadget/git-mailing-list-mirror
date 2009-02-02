From: Tim Visher <tim.visher@gmail.com>
Subject: Git+Ant status?
Date: Mon, 2 Feb 2009 16:12:27 -0500
Message-ID: <c115fd3c0902021312v1742f883hc56822bea796b55f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 22:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU677-00052Z-Ug
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 22:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbZBBVMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 16:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZBBVM3
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 16:12:29 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:3890 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbZBBVM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 16:12:28 -0500
Received: by an-out-0708.google.com with SMTP id c2so675484anc.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=y2HH8czimpiumgQTQSoe5Eo0he9WNBM2KTsClTOm/6U=;
        b=k/rvMiu44qW8gV6EAWXNsm8Ud4NO8yMC25ZcPUauUu6VnqO/8kkSxvKc7vlPfJm3dA
         R9wB7a6kMIInKZdHiQo8rnavPSzbCJTYDl/yfkXfjlW9drHThhTM2naefD0YsZauwKSW
         L0axxblFe9Rn16pfFk8TgfxF0EZdMe2+Ltdi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bPrBYb1cY91zkewf1AuwrdHDqEPDed2HvJAMuJXVuKteMxhz+6mCe/jHNAIlxK/iy+
         bE3MmdYMB8Jbvl5jGl3la2gVD5Quyh/+3jWPJo9m3o2KYy+LMotg67TqXYDJephq2/6s
         XirA2SGheam4x6Pu8wRVgeDYIC8mB6FZ5c9A0=
Received: by 10.100.57.13 with SMTP id f13mr3175108ana.143.1233609147799; Mon, 
	02 Feb 2009 13:12:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108123>

What's the status of git's integration with automated build tools such
as Ant or Maven?  Is anyone doing something like this for projects
that they're working on?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
