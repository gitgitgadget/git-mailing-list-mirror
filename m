From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Anyone have access to 64-bit Vista?
Date: Tue, 27 Jan 2009 01:30:38 -0800
Message-ID: <83d7aaa40901270130g3bebb3d6we4839b567f310e46@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 27 10:32:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRkIx-0003H3-9I
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 10:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZA0Jao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 04:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZA0Jan
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 04:30:43 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:49453 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbZA0Jam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 04:30:42 -0500
Received: by qyk4 with SMTP id 4so7078738qyk.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=H5k3E5gSNW/UT2peXMMHBTEEKZLpviY1Uo48nBvhPyY=;
        b=T/0MFfHwBbycS+45MG3e5ojeldOiwcEBM/p1eeR4l9AiT44OSxIGFxAuC+bYwfe0/G
         lhQeQacnHti81pkRrF4ksjmEvn8wq9A7l06MfAIkBDUpH3UBY7D1O1lEdemueYLov2NB
         bl2fdzF+QNkECkwom5bCOXy7Tn8qmSRUPD02Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=teWBqi2fByljaA9ESW1tvCT9FuswS0BCnqQW2BaC6dswSuvhYt1guHhLYx3ZJ5FiPS
         91c/lIWmpYzPiYnxNMU3hg0CA8OrZ4n5UKiYjBZBRgyhnZoi38vCqEDpVmx2G/Sa2nlV
         QhIeiTAYrcEJ2WWxwWsrk+qji2eF6CA8HUbxw=
Received: by 10.215.67.17 with SMTP id u17mr9032077qak.382.1233048638500; Tue, 
	27 Jan 2009 01:30:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107325>

I'm trying to develop for TortoiseGit on a 64-bit Vista SP1 system,
but I'm having trouble registering the shell extensions with explorer.
I'm hoping somebody else here who has access to 64-bit Vista can tell
me if TortoiseGit runs on their machine? I want to find out if this
problem is only affecting my machine.

http://code.google.com/p/tortoisegit/

-Geoffrey Lee
