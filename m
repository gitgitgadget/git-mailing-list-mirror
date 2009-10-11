From: Dilip M <dilipm79@gmail.com>
Subject: git log --graph
Date: Sun, 11 Oct 2009 23:57:33 +0530
Message-ID: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:36:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3Hk-0002dt-PT
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbZJKS2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 14:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbZJKS2b
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:28:31 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:38614 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbZJKS2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 14:28:30 -0400
X-Greylist: delayed 6573 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2009 14:28:29 EDT
Received: by pzk32 with SMTP id 32so8397996pzk.21
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=UYnFGVNiIMFkNu5+FahppxmAma0rkcPEg9HZYPGZiEo=;
        b=GAPttW1zESzwzUUcjRXnv8QlkDeAIL3FWfEL/6Zggz9aa9cQlL23WwAkcATAGzzSHT
         vGiFBcnrrU+i2Jk7B+nPaqj8O0+olkbAwbogswhuhwxY7wO87JDxytIgfYa36qSqPaD5
         eQTwPdtliKWd57C4zA4zcLVQHgg9Ykk3sKezU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=tlaBVCEl1lQhdoCggNoo/eK8xDwb3T0vKPKkf0XPFssRmx7cWSHoWGZaP2fel8zbS9
         5wdaYSDc9EZhN814+ZDG8dlActBTdJ1WQ1IcRQVZVW5kGlDKSGHem9Ute1NDii/el4Zh
         KHf2BWvqhgqdlVcmbfRspBn38VZ72eFSEPPvQ=
Received: by 10.140.165.7 with SMTP id n7mr333324rve.270.1255285673065; Sun, 
	11 Oct 2009 11:27:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129939>

I am using: git version 1.6.3.2

Somehow not getting text graph as mentioned in
http://www.gitready.com/intermediate/2009/01/26/text-based-graph.html

Any hints would really help..

I am trying git log --graph. (has commits in two branches...). But
always see one line :(




-- 
Dilip
