From: Rodrigo Rosenfeld Rosas <rr.rosas@gmail.com>
Subject: Translation inclusion criteria
Date: Tue, 22 Mar 2011 09:57:45 -0300
Message-ID: <4D889CC9.4060603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 13:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q21AB-0003zB-Uh
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 13:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab1CVM6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 08:58:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57879 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002Ab1CVM6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 08:58:11 -0400
Received: by gwaa18 with SMTP id a18so2833894gwa.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 05:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=4CR3bNNy3XrSMxAx5J9iO2iEFLSkY7KXq4u5DetAqQA=;
        b=dNiy16thpTCI0AaLrwr/+jtHczF60vNgaR4IpJvJOVWBcLQyl5IPXXxWK+lQijRJ+j
         I5wEw95jmX521vvAJIGFnOV5/T89h0RSafgTLxOfaLcXJkR3pCNmwkDD4bk28TK/Yg6s
         cnnX/RiyJ+oVTmFOThhIEu4hHUKEWGjfV5WUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=LjkB/33fbgnG3ety20rHZRIF3cAoQpN00NYrOqwN/1lw/D75uD8mjMxhV2A5VL7aAD
         el+fB8XBUn5QG8OVneqdvLkZvCVni2hH0e5iD8mbaBzP8i6mOXVSs53l3oKQfAr3R5Qe
         LeZ4OAhrMwqWQxRQxvi6PiVieBPLBBTcVmUqU=
Received: by 10.150.235.20 with SMTP id i20mr5299448ybh.232.1300798690399;
        Tue, 22 Mar 2011 05:58:10 -0700 (PDT)
Received: from [192.168.2.236] ([186.212.123.220])
        by mx.google.com with ESMTPS id d3sm1678218ybi.20.2011.03.22.05.58.06
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Mar 2011 05:58:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100918 Icedove/3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169731>

  Hi, I've followed the instructions in git-gui/po/README in 2008 but 
pt.po was never included in master. Now I've just updated it.

Is there anything else I should do for it being merged to master? What 
is the criteria for including new translations?

Thanks in advance,

Rodrigo.
