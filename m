From: Siju George <sgeorge.ml@gmail.com>
Subject: XML Parsing Error: junk after document element
Date: Thu, 11 Feb 2010 13:17:22 +0530
Message-ID: <b713df2c1002102347g70cc212et21d507d44bb5aead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 11:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfW4I-00088f-TK
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 11:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab0BKKOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 05:14:38 -0500
Received: from mail-yw0-f115.google.com ([209.85.211.115]:37868 "EHLO
	mail-yw0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0BKKOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 05:14:37 -0500
X-Greylist: delayed 8834 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 05:14:37 EST
Received: by ywh13 with SMTP id 13so122037ywh.15
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=eEmir/ENXXmsyKaGW+Dw5f3vB2IKkI6vnCIMmjyPgDY=;
        b=JyTeKHwt5uzAm4K5R7zVuwMtw6k5ooft/xvSCIrJMniNWl8HBqKsL0gAwxiAeqpL66
         lSW6fwXzhjZQVqbp5Ht7spMQ7rhwVN4t2QlFyU+SyNrwlUDMfj3SQRBhZe4LCY33GJeu
         nYyWxwXUjlGj3qCH52bTbwM4tqKk2TrfA7MCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=S6OglgYvnOAosTaEHgP+UsmhnCRnJAOhUiSEnGnwnMdUiC7cBV1e8dEqXFpoZ865FN
         y/syzmgBd/XNn5GugxVYIunK8Hwy8VWVCikXtwXah3WffZ+3iQoZC4qvgZ8VN0qQ+xjv
         xJo/j2k49LcVnhwsGU8Cds/WlSOzNJsH0arVs=
Received: by 10.91.51.19 with SMTP id d19mr2671241agk.101.1265874442942; Wed, 
	10 Feb 2010 23:47:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139582>

Hi,

I get this error when I take gitweb in a browser.

XML Parsing Error: junk after document element
Location: http://172.16.3.27/cgi-bin/gitweb.cgi
Line Number 28, Column 8:</html><!DOCTYPE HTML PUBLIC "-//IETF//DTD
HTML 2.0//EN">
-------^

How can I solve it?

Thanks

--Siju
