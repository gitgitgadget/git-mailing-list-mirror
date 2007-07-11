From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Build error with qgit4
Date: Wed, 11 Jul 2007 21:49:25 +0530
Message-ID: <cc723f590707110919i7def2fbal94b1a437f189040@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Marco Costalba" <mcostalba@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 18:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8euY-0005rk-LP
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 18:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbXGKQT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 12:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756853AbXGKQT1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 12:19:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:6187 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834AbXGKQT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 12:19:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2361919wah
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 09:19:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m/tXhJgDc0eZIkY35nLtdSLtYltEjxrLqmoewgrGLLMq4UHp04djc5T9rT/QAr/3GXc7DPmxLofrePm5F8HmPLNntkv27oz17LD4HhHVW6v8mkEQVeyMMgPA2F3uftJxURTXkURLVvkAglUO1LAq6NCu/y0ABc3aujNp67xGMLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qZglasUPJNV7D+d23z8CUVufR+jZdPB5b1G/G026Lz5IACD387e2Fgr2HLxXv+3scp2OSPM4yFD7DLxbKAr+nAXA9C3WAjPmltG2wdtoskAjT4/V+hO4gYkp4s5Hx2gxBt5HkRVVhcPzgSEEJNv1I2ktGelMjwpbvjc1UMEzacU=
Received: by 10.114.59.1 with SMTP id h1mr5274296waa.1184170765939;
        Wed, 11 Jul 2007 09:19:25 -0700 (PDT)
Received: by 10.114.240.11 with HTTP; Wed, 11 Jul 2007 09:19:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52174>

lude/qt4/QtGui -I/usr/include/qt4 -I../src -I../build -I../build -o
../build/fileview.o fileview.cpp
../build/ui_fileview.h: In member function 'void Ui_TabFile::setupUi(QWidget*)':
../build/ui_fileview.h:63: error: 'class QHBoxLayout' has no member
named 'setLeftMargin'
../build/ui_fileview.h:64: error: 'class QHBoxLayout' has no member
named 'setTopMargin'
../build/ui_fileview.h:65: error: 'class QHBoxLayout' has no member
named 'setRightMargin'
../build/ui_fileview.h:66: error: 'class QHBoxLayout' has no member
named 'setBottomMargin'
../build/ui_fileview.h:71: error: 'class QVBoxLayout' has no member
named 'setLeftMargin'
