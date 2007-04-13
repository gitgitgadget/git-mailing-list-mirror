From: Andy Parkins <andyparkins@gmail.com>
Subject: Ignore BASE extension
Date: Fri, 13 Apr 2007 12:33:12 +0100
Message-ID: <200704131233.13979.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 13:33:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcK1u-0007O8-IW
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 13:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbXDMLdX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 07:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbXDMLdX
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 07:33:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:7000 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbXDMLdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 07:33:22 -0400
Received: by ug-out-1314.google.com with SMTP id 44so524442uga
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 04:33:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cG+msWIjv2ov5/2V3QHakVVZWK1n8Jq9s4BmWdyuxuTQ0K6XTKBaQ2OD+knm3wiwXt1zIZ7D7yspYaOJuJwbzOZae4pCI84nwsUeBHXyx8aiCaDDWcc2mh+Km6poJcQrM8Q+SQ8DnEeZZnicpd1vTzY4Oya+FqQ7vtXxOFYcCss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ikRw3Ruv8fVsUkQjopgKJOymJao5V8LM53SSMAgQhAHnnFK4oASelsNfajja4x+0WNMsiZ/3ksRu6uxE4aSDOhe/HQi7gFobMGGb+pcUYKGs/x4Wcpgs5i14UEZ/NcUSvPQhNFfg7cSIQ2vCPDm+x7stWmNmfAXfHiyzuOEmp0I=
Received: by 10.67.76.16 with SMTP id d16mr1943494ugl.1176463997283;
        Fri, 13 Apr 2007 04:33:17 -0700 (PDT)
Received: from ?192.168.11.214? ( [84.201.153.164])
        by mx.google.com with ESMTP id j33sm3688168ugc.2007.04.13.04.33.15;
        Fri, 13 Apr 2007 04:33:16 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44403>

Hello,

$ git --version
git version 1.5.1.1.83.g2bfe3

I've just compiled the latest version from master; and started getting 
this message

$ git add foo.c
Ignore BASE extension

What does that mean?  Should I be concerned?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
