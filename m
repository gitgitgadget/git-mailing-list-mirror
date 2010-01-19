From: tzachi perelstein <tzachi_perelstein@yahoo.com>
Subject: Re: git-describe recognize modified files
Date: Tue, 19 Jan 2010 05:07:29 -0800 (PST)
Message-ID: <228075.79497.qm@web45206.mail.sp1.yahoo.com>
References: <829260.92036.qm@web45202.mail.sp1.yahoo.com> <alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302> <20100119122122.GA28667@inner.home.ulmdo.de> <m34omiclap.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 14:07:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXDny-0007Rm-1J
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 14:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454Ab0ASNHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2010 08:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450Ab0ASNHa
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 08:07:30 -0500
Received: from web45206.mail.sp1.yahoo.com ([68.180.197.95]:42296 "HELO
	web45206.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750898Ab0ASNH3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 08:07:29 -0500
Received: (qmail 83532 invoked by uid 60001); 19 Jan 2010 13:07:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1263906449; bh=cKZA0sP4T2iJehQkNsR6Li7tVRexCvDwjwGsRASeUm0=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=XUGZB9x732r0DOz555HN+Pdj897KdxyHIvpyEpHk72WFh7we7nv+dixMakLblwTLn95babUfVobvF/A3hcZ4RlIgFQQbuzbXeMQhMT0liZTGlm5eSCimElL+kLnCJFHwUfJynuiv9ttIhuia+Q5VIa+LJVJO2FuxAeW2Fo/F0d4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:References:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IheHmNqwls41NNhb+/AFgkWHOR+u6TQ3rB7/Nts2bvNcd5LJNy0gBAYDqofOuO4qitFeSAhHnbJsQegRchfd5N7DcmDYzEeMllOyS2QYr/xQv5+pXXbAomqm3VcdZfznxcpJfhE3CMmoPObpDEa7FZl74JbJ3SnH7+LIjZ9YLtE=;
X-YMail-OSG: 9VIYdMcVM1lhWfGbDA4sqjfklBomIvdNtHSW48Tg3ghHW4r0DyA.axhuUMzohPBd1svHyH.u4Q9STdYCXskMDj3d65zqbaXda2i7h7q1nb18aMe.rY9H5F2mrP.DeTWjW8yQoeFZwbeyyKlR0h5aAwaOUFlDsZujgBfcMkpY8H2SDw06_vxwH_h1scBpcbsIPkcwBm6r8s6vZ4AOfdhOy1hND8.QUtv0E0MJr2BNypmEnmNkqE7VcTMzsrMAxXQesnA7AuEpl_av0cXJd6DXric-
Received: from [80.179.89.178] by web45206.mail.sp1.yahoo.com via HTTP; Tue, 19 Jan 2010 05:07:29 PST
X-Mailer: YahooMailRC/272.7 YahooMailWebService/0.8.100.260964
In-Reply-To: <m34omiclap.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137455>

> FYI it is integrated in git-describe since
>=20
> =A0 9f67d2e (Teach "git describe" --dirty option, 2009-10-21)
>=20
> by Jean Privat (it should be present in 1.6.6, IIRC).
>=20

Good=A0news :)
Thanks



     =20
