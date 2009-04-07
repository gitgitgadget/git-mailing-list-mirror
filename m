From: Tim Visher <tim.visher@gmail.com>
Subject: Showing the version of a file that's in the Index.
Date: Tue, 7 Apr 2009 15:59:49 -0400
Message-ID: <c115fd3c0904071259y53b4b264u9c9957b68e36cc44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:01:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrHUE-0007No-GT
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 22:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760547AbZDGT7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 15:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760553AbZDGT7v
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 15:59:51 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:46227 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760525AbZDGT7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 15:59:51 -0400
Received: by an-out-0708.google.com with SMTP id d14so2375474and.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Pb0pfF5WKgKH72RcYqq/oYNcl43O9y0t9sNu62UsdnM=;
        b=OID6A6WO/tOzZBuc47aiHIZRGeUdNc3W2Gp1JbnJLIU6xQVMY0Y/blBS8fHRk+fIYG
         vgIF/72pPv6g5A23i5bTNzlUFOHqxGc4XFtYGq7JXSFvd3RLEUTAgZg1Vm4JH502Ln2A
         L5jLEEIL3/qo/fnVsSZ0LzciDTmhjngsWnhAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=G0tzS0Y8aFqZqe80scdDp5CFKheGdYAocrkapqCw8itjmwyXTAM/woGz2aKCe8GT9G
         ZKmtBdOTWNbS27T6ZOJ4LRtcQvErC6TLtH+ZI97Sc/p43cTNCYcB8rVwEPR9ozGTJhyL
         O4gOaVjFFAOsMxXeIpuDvbbFhpjdH5b5ma3d4=
Received: by 10.100.58.18 with SMTP id g18mr967040ana.125.1239134389418; Tue, 
	07 Apr 2009 12:59:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115980>

Hello Everyone,

How do you go about showing the version of the file that's in an
index.  I'm currently going through a somewhat convoluted in-file
add/commit process and I'd like to verify that what I'm about to
commit is in fact the version that I want to commit.

Thanks in advance!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
