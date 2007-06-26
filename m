From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: git-gui and untracked files
Date: Tue, 26 Jun 2007 10:02:40 +0200
Message-ID: <8b65902a0706260102i25f79375r5e5b419107f6e587@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 10:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I360d-0006i5-NO
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 10:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbXFZICn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 04:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbXFZICn
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 04:02:43 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:32098 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbXFZICl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 04:02:41 -0400
Received: by an-out-0708.google.com with SMTP id d31so370110and
        for <git@vger.kernel.org>; Tue, 26 Jun 2007 01:02:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NT95qXVcToDZFmiZCrDhp756ziH4zq/UjiKAfUfwNHmy9hePWJPK/p5RPZcffzt95ZJi8nrK/uZOgBAsfQTVH4OIMOY6pfA2AFwskCNiVOvAXTc9RRG9Jp8PUYUr6XR4iqH+oEyb1D2SuX0j48k/e1iZ+IKx8PIRYxbT2bNrWdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OT8gXOzdNvcGqrvqRK3flfkl3nGnIJfKNjsQK1avH8C7r6WeN/jgWorfT2pJDYpH1zl5jqVjbRXWssxG99GC27g2ToYb8RaQoqEReqDHjq2OjHOe5PHl8U5XhecjY9GWixnlvtatG8lRCATHfEToZoJVpkr2HCcOUCDxtAr02nI=
Received: by 10.100.93.5 with SMTP id q5mr3593022anb.1182844960874;
        Tue, 26 Jun 2007 01:02:40 -0700 (PDT)
Received: by 10.100.44.8 with HTTP; Tue, 26 Jun 2007 01:02:40 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50954>

Hi,

On my repos, I have lot of untracked files. In the same time, adding a
file is a really occasional action.

So, most of the time, I'm confused by the git-gui which shows me lot
and lot of files, where only on or two are interesting for me.

Is it possible to hide untracked files in git-gui? (for example an
option available with a right click on the "Changed but not updated"
frame)

Thanks for any tips.
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
