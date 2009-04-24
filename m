From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 19:18:37 +0400
Message-ID: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 17:21:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxND6-0000H5-75
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbZDXPSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbZDXPSj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:18:39 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:41996 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756867AbZDXPSi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:18:38 -0400
Received: by fxm2 with SMTP id 2so1160150fxm.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=8pg/hXbhnktjyeNbbP52tb4otronp+aj57XUbz4MFVc=;
        b=Q8qXZkgRkJKuF2qYRzSlmVN2ch3/9wdieEJJnk61MxI0QwnL/JF93WK8s8a4pgRrYA
         nUNQCf0JYyZz8YeF6hTJi4SDyw26EQiUp6dXT8PC/Wi9uxfWHH4aai8ZOQe6nM10PkBq
         japQ/vtM/NIgrslA6Utp1OedpqEgU4rJecGcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=QtTyd+3AeVGuQ0Mqv93XR8zsc11+S/C/jUPZeJEubovCm0xNPOlRXx2V90kyrqUauD
         JlWprc+PxyMOciKfD+8fI2A1eLDL2+xHNYfHROhJDh4sGjXJJnBujEmrIR6yRQluwl4x
         RuiNy7G5gxEaQJ6fkvykzjKiDW1Gzi2FLJNiU=
Received: by 10.204.102.14 with SMTP id e14mr2122514bko.209.1240586317105; 
	Fri, 24 Apr 2009 08:18:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117450>

I'm interested how to modify subject prefix when sending patches using
git send-email. I want it to prefix the subject with [JGIT PATCH]
instead of [PATCH] and I have not found any option that allows it.

Regards,
Constantine
