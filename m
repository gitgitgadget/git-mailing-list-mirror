From: "krahulkumar.1986@gmail.com" <krahulkumar.1986@gmail.com>
Subject: Installing GIT on Solaris 10
Date: Tue, 08 Apr 2014 09:46:35 +0000
Message-ID: <5343c57c.454be00a.6d19.5b78@mx.google.com>
Reply-To: "krahulkumar.1986@gmail.com" <krahulkumar.1986@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 11:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXSc6-0002F1-5E
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 11:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbaDHJqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 05:46:38 -0400
Received: from mail-qc0-f173.google.com ([209.85.216.173]:49645 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaDHJqh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 05:46:37 -0400
Received: by mail-qc0-f173.google.com with SMTP id r5so655205qcx.18
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:mime-version:date:subject:from:reply-to:to:content-type
         :content-transfer-encoding;
        bh=eCEBh1279ODW+Lb/iqsc5q+wIJZwgsjNKBOPWDF6v+E=;
        b=Jw8xLn38D88LI5cvI722qa/0+exjveWMmfQ+XbwlrBawzKEHEsQTnagNm9aS1u/PS9
         WrlDJjEUBLlmVkuph1XK6pqbEsJ2XInnHTZjbcW/+QTsm6FlM6k0fmXkTYik+izCPVl0
         zHfRZsZ4mpytxTjfMSgPGlckBvFocsZC7x1IrtW2LPjTfjpm6CkHDVz4AX2/irwQHts6
         EX+7cMZqE0vYv5hzvJ7hzlRc3T5j6hHObnehGSOK+v6c7RBY3JexfT/wsxQoheHs1ce8
         IA/tbHAxRWiUkuaZUQVNR1uZMsHIOM6AP0+d8mEAVBSRWGuUUwbbwqCIpiIcVrxTPLpo
         ElbA==
X-Received: by 10.140.36.179 with SMTP id p48mr2851696qgp.54.1396950396571;
        Tue, 08 Apr 2014 02:46:36 -0700 (PDT)
Received: from nokia.com ([66.54.67.69])
        by mx.google.com with ESMTPSA id x5sm3129710qaj.9.2014.04.08.02.46.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 08 Apr 2014 02:46:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245921>


Hi,

I want to install git on my remote Sun sparc Solaris 10 server. Please help me with download package and installation instructions. Also help me with the dependencies. Thanks alot.

Regards,
Rahul Kumar
Sent from my Nokia phone
