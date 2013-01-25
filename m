From: Jiang Xin <worldhello.net@gmail.com>
Subject: Git 1.8.2 l10n round 1
Date: Fri, 25 Jan 2013 12:54:51 +0800
Message-ID: <CANYiYbG8T+JDQe=LvBb85JKZGUk=6H-f2aLvoaWW4cg8arByHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?B?RGF2aWQgSHJiw6HEjQ==?= <david@hrbac.cz>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TybJr-0000WH-C0
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab3AYEyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:54:54 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:62762 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab3AYEyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:54:53 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so821821wgb.4
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to:cc
         :content-type;
        bh=HkgHWafYuNkACAXxpRNIDyUkqLjpyOaUr0H1kRIuJWU=;
        b=sGJgwiuSs4AwQdIPigTHOCwNk935TfUtSFjxjKN8hrQErHrV01IMFGklUYTqznsPZb
         F6/5rntXJhwfXL8n7gpAmy1IpNcxUSwVgYfi+7Nefs3U1maKjpJJ8Ems07yILjH9mGPf
         eUh/L1Ui+IwhXuYDMr5G7npMWqemJmIU3m9eLvAedZTlGWO2ymj5HL4Hap4sfmChCquF
         xcMIxmqpKdyBZTf/xcPMF8VLTrdDBJeQv3MpqRLMYTOd47Lh3DB2siHSDgs+ChF5tUSU
         PLoLA+yuoXHczZ0v9p649VZ/9nbtjMAUibljZ0K5yABAzfa2AC/mKc3P0TbqxFAgSx4F
         0whg==
X-Received: by 10.180.101.99 with SMTP id ff3mr6489756wib.21.1359089691427;
 Thu, 24 Jan 2013 20:54:51 -0800 (PST)
Received: by 10.216.106.65 with HTTP; Thu, 24 Jan 2013 20:54:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214493>

Dear l10n team members,

New "git.pot" is generated from v1.8.1-476-gec3ae6e in the master branch.

    l10n: Update git.pot (11 new, 7 removed messages)

    Generate po/git.pot from v1.8.1-476-gec3ae6e, and there are 11 new and 7
    removed messages.

    Signed-off-by: Jiang Xin <worldhello.net@gmail.com>

This update is for the l10n of upcoming git 1.8.2. You can get it from
the usual place:

    https://github.com/git-l10n/git-po/

--
Jiang Xin
