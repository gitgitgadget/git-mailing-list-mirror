From: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
Subject: how do I install "git" on Redhat linux? (getting confused)
Date: Fri, 6 Feb 2009 10:23:17 +1000
Message-ID: <d30068860902051623w758bbfccrb1acca0adaf4a59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 01:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVEWW-0005i4-N2
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 01:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbZBFAXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 19:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbZBFAXT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 19:23:19 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:5190 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZBFAXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 19:23:18 -0500
Received: by wf-out-1314.google.com with SMTP id 28so590212wfa.4
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 16:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Wykbz/e1PAgKvUhkJ5xRV8gSSfhYGPqMwv2iQlmMxpI=;
        b=QingNsK/0fkEJuJc1ntE3qypSCGKNdOgefB1dQVQji2T/EHNY7WkphjOgI5J4UatId
         8a/EiLXvN2+IB9KxSCSeq2pDFOYNDvck47wBIiIoQZnMIMKeHAhEjE4hJyHL0bf8G7oS
         ATALc7WwF7CXAywIHQ8yJI5i/HQ3ZN//jGoRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sPPLUoBUEEj2EbFXNHhzFvKuzmZEQZXgwPptepBQAtcztg7mV3OYaOdzOoQiJg+mGT
         1Zerp47pLjBngTq5Gw4ARGsQEqrdbuxBknffrZHXNaKNr2iPM8M4UTM7pcPTtTMQfGXn
         LmpAZ4TMgkroqraBrXHnb4uJRDLeyJmZ52AZ4=
Received: by 10.142.128.15 with SMTP id a15mr623544wfd.84.1233879797947; Thu, 
	05 Feb 2009 16:23:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108638>

Hi,

Can someone give me a pointer re how to install "git" on Redhat linux?
 I'm getting a bit confused with all the different approaches I'm
seeing. The linux box I'm targetting is running clarkconnect
(www.clarkconnect.com) and underlying system details are;

[root@home ~]# cat /proc/version
Linux version 2.6.18-8.1.14.3.cc (devel@cc4devel.lan) (gcc version
3.4.6 20060404 (Red Hat 3.4.6-8)) #1 SMP Mon Oct 22 17:57:16 EDT 2007


Thanks
Greg
