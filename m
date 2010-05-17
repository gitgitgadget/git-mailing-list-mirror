From: Eugene Sajine <euguess@gmail.com>
Subject: stupid error - is there a way to fix?
Date: Mon, 17 May 2010 14:32:05 -0400
Message-ID: <AANLkTin32LGzfA79XYfivdun0EwWTs8p_yBeR030_2N2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 20:32:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE56t-0002HD-UB
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 20:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab0EQScK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 14:32:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63894 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0EQScG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 14:32:06 -0400
Received: by vws9 with SMTP id 9so1995612vws.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=x5w/9T6lpvShvvO7/fPkOmHyb0l6nGP1QEIooExBOHk=;
        b=m21B+EYjj/zc0Vg14V9adZI1jmviT6bZ22s2rQdFUGaVjd5ZOZGymIPTcQzsnpM/Xi
         5RZUbMDjTcRaRoaQHENjm3ips7r+LpzptDVXQRVWJJ7QcDZtTuZxagtUzsScyN47cZ5y
         6hTJm4XzrTfcURe3ww3wTWeGHPYz+teqvuIiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=KKTMgA3bkNR09jZ5KWQTKxrjlTtHQHd5kwfZFFqWqz/MuZt18W9w7vgHVaFCcsuPAl
         E8WVZ3QOQ779fy6bG2BMbs7Tv7IYCTyx5ZWRttp9XybRKGjxzW+z88GfM3EPf0IZ1hkp
         TKlQJRItmksQDegnyx8Xmkls0fVYRsQ9dzcQs=
Received: by 10.229.181.138 with SMTP id by10mr1231304qcb.9.1274121125876; 
	Mon, 17 May 2010 11:32:05 -0700 (PDT)
Received: by 10.229.242.3 with HTTP; Mon, 17 May 2010 11:32:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147249>

Hi,

Wanted to share some Admin nightmares;)

Is there a way to correct a stupid error when few commits were made
under username Your Name and the same kind of stub email address
instead of normal name?

Thanks,
Eugene
