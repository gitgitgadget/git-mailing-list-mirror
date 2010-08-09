From: Sultan Shakir <sshakirflhosp@gmail.com>
Subject: Git and Documentation
Date: Mon, 9 Aug 2010 13:35:39 -0400
Message-ID: <AANLkTi=P=RsToSor=giC+dgV24bPj7KJ3eRV1M5a+iuD@mail.gmail.com>
References: <AANLkTik_rO_+az5kE=yhfXK1uUO3v0RKdcO2hzFBcZym@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 22:06:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYbx-0004lD-Ut
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 22:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab0HIUGN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 16:06:13 -0400
Received: from mail-gw0-f66.google.com ([74.125.83.66]:38895 "EHLO
	mail-gw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0HIUGM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 16:06:12 -0400
X-Greylist: delayed 4806 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2010 16:06:12 EDT
Received: by gwb11 with SMTP id 11so1736121gwb.1
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=VlEQHHToL7h5jbxuGkEcW8ktaQfJVrxYaJR4RSewkbQ=;
        b=VCPgwnyiDRnpK8GSC0j1lSIqQe9bOp0+MVAXipI+oHPz06O4y6pqUjimtUY60Lpr9Y
         QSd0lXtvp8xZO7jSD3/DWMPQV5IDxmBbwVgIY7xxHFyWBXlSW4FV5T+//Zyuh6guuol2
         ZhaH4w2tkby1mNY9aEb56ULia0FWRf4Zqzjtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=k31MruRUn71RrMJve5ga6BhzlKwSBmj8xsfCtnYv5RIwdv1cNv0BOPj/e3kdDh7b8T
         lb3b1UtCnsYDGkAKB0bgGkrPniFE3dmSAvXgEl4eJR4O5IOSeVvRBjDzHalmiO9o76Up
         CXG7+NMcoa8wP0JAwhSDQRRxKZIR3SOOscnH8=
Received: by 10.100.34.19 with SMTP id h19mr18375805anh.2.1281375339232; Mon, 
	09 Aug 2010 10:35:39 -0700 (PDT)
Received: by 10.231.205.210 with HTTP; Mon, 9 Aug 2010 10:35:39 -0700 (PDT)
In-Reply-To: <AANLkTik_rO_+az5kE=yhfXK1uUO3v0RKdcO2hzFBcZym@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153013>

Dear Git Community:
My organization is exploring using Git to manage our code repository.
We also have a strong need for documentation of our code. =A0The code i=
s
written in a=A0proprietary language (Discern Explorer/CCL). =A0We looke=
d
into Natural Docs but don't think we can combine it with Git.=A0=A0Does
anyone know of an app where we can combine the power of Git and code
documentation in one? =A0Thank you. -Sultan
