From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: mtimes of working files
Date: Wed, 11 Jul 2007 04:08:12 -1100
Message-ID: <f36b08ee0707110808h56ecbc7at9c92727c01cca508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 17:08:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8dnd-0005AA-Ni
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 17:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758534AbXGKPIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 11:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758926AbXGKPIO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 11:08:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:16123 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758342AbXGKPIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 11:08:14 -0400
Received: by wr-out-0506.google.com with SMTP id i30so839880wra
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 08:08:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CpmYoskei9oetQeaC1lwayFIIVyUzlZ01FTnKX1JCs9ND4t7aD1AzNdXuPboYu6B986bMcGxnImPzdFiwzWMU16BAwGsVgegYqmEMspxSGUiFNmSo6jQ0I4dqMigXs2IEmYIWDAxi3isml906CT8HRJlz+aE7O3U34zDfI+T7Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=T7M/plbI9jCTPS7/BREfnQSp34H1J0HsjzTyJ3pa2os4v7ZN0tTQf6uuK+CKoe6jw1YSfOimla+77jZNQR2bTW/FzmnBxHoBanzhwhrUQ/QJEEC0uFx7YcG8skiSheJnME143znBAnguPi3Z9GYM6+TgJrCCWcBrLAR3Qj5BqBs=
Received: by 10.142.242.8 with SMTP id p8mr404128wfh.1184166493069;
        Wed, 11 Jul 2007 08:08:13 -0700 (PDT)
Received: by 10.142.116.4 with HTTP; Wed, 11 Jul 2007 08:08:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52167>

How difficult is it to have script (or maybe existing git option)
that would make mtimes of all working files equal to time of last commit ?

Thanks
Yakov
