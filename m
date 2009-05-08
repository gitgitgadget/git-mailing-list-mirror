From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: List of "remote capable" commands?
Date: Fri, 8 May 2009 12:34:10 +0200
Message-ID: <33f4f4d70905080334w2e49bb36i34ebd64aeeb3e15b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Users List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 08 12:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2NPz-0004wa-Uh
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 12:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbZEHKeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 06:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbZEHKeM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 06:34:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:43750 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347AbZEHKeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 06:34:10 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1224962wfd.4
        for <git@vger.kernel.org>; Fri, 08 May 2009 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=z1LQzi+fWxxz0Bnk12WKvAzTBEzxTwnbINKU+Gqbays=;
        b=hSXWu4ptPTbeZ2UzL3Sbwndk3beEDJPSyDi2C2/1XN5S6NGC9CEy2zso+xt+Jx5/r4
         tAGNLVpd9GU0+AA7SR+0OZss5Iade0sOyL9TnGVYB4VlBllkc3HdEyw+uxLU10JNSCXx
         aO2DxySN7T0kyxUlOb10kX/Rc1SCXh+nqiPmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JZDaO0gSvv2GwKeT0v5WxXHNCSSgttHl/ipo/kuXWDhZjTg1ldApXVdMIOzXF+iVEE
         xyzfuJN2AUZcArJHi+qTenSZBo5vW+60yQK8NdAq+OoaQqcnZIQzfi+om3Ty1u6/Bmea
         zkl6+CgzhFrszpsnpBl17lorrubEhsuid59GQ=
Received: by 10.142.126.6 with SMTP id y6mr1528237wfc.204.1241778850381; Fri, 
	08 May 2009 03:34:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118597>

Hello

Is there a list of git commands that can be used against a remote
repository? E.g. commands that work over SSH?

BR / Klas
