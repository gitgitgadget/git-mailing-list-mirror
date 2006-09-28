From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Why gitweb commitdiff NO diff output ?
Date: Thu, 28 Sep 2006 15:32:51 +0800
Message-ID: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 28 09:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSqOL-0000EM-Ft
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 09:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWI1Hc4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 03:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751749AbWI1Hc4
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 03:32:56 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:56587 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751746AbWI1Hcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 03:32:53 -0400
Received: by py-out-1112.google.com with SMTP id x66so628040pye
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 00:32:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PHLJpFnzZpmtEit6N1RhdjEoONtlZPDCU2Tdu8sT0DXG8P8OqcsGquLKIWIIl3eybYDL2O4WZlKOe2fjCrIeoG7RF85Uo+47j/J7aPwAndxGYGY95QAWoJ44+oBiAx2IQSqI1K8tz15z8+8xJ9Nkn+kMTVHCv3c1IpuQhAL+bNY=
Received: by 10.35.114.16 with SMTP id r16mr2562944pym;
        Thu, 28 Sep 2006 00:32:51 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Thu, 28 Sep 2006 00:32:49 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27992>

My git repository import from subversion, and the latest files has
correct mime-type property, but gitweb commitdiff NO diff output !

file:82dc767b3f1425435fa6d8fa7511718d3f614172 ->
file:4c7269ed65bf8691c46541497fbecc706f7d012f

file:6817671d9af75b9adcc439d62f9047c7b2a9adb2 ->
file:575d40108f550ac5965bb6ea8b6792fa9cc10536

Thanks for some help,

Donogsheng
