From: Dotan Barak <dotanba@gmail.com>
Subject: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 14:37:02 +0300
Message-ID: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 13:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGAV0-0006jf-LL
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 13:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbZFOLhC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 07:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZFOLhC
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 07:37:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:33704 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZFOLhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 07:37:00 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1079081fgg.17
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=u1L+SJukF0DGazuEvGcHG8u579rUr1B3DP72nKdISgs=;
        b=qBsipTsX0yVs+8ETrr3QpL0kpI4UgDwYKc4QnvGckYdywAXjdbDhSgB0ueCD9Bhnzw
         Q1uuACLZgat2Lk+IJLvcxqLGkZWnysbJu1XeLDHL+5J9wn61PHP97sop2wMODJ+MkK8X
         CVE01RHcH8O3WrAs49d/DkNazmtCmmGnBAXyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lgmM//3V6tiSucptPOcqGt3wXZTg28TggL6mam2I/gJCinAa3W6iHz3Shlv8s7eqHZ
         bwgtKTbM62xcdueyXy0FiDflak+ter/xor8lVJ3IYG3aIaXeJ2NR1jA66wuuIa0LJrQu
         4miVQZw1+0tYpdjiu4Ly2gKgv/cT8g48NuYaU=
Received: by 10.86.36.11 with SMTP id j11mr6558446fgj.56.1245065822161; Mon, 
	15 Jun 2009 04:37:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121596>

Hi.

Is it possible to find the origin of a branch?
(the remote repository that this branch was cloned and checked out from)


Thanks
Dotan
