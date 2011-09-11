From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Git wiki down?
Date: Sun, 11 Sep 2011 13:56:12 +0200
Message-ID: <CAMXnza1fwgup_YbbrvM7egpZnaUBBV935x4ib72MO=TmvHS3Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 13:56:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2ieQ-000821-L5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 13:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055Ab1IKL4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 07:56:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54100 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172Ab1IKL4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 07:56:36 -0400
Received: by bkbzt4 with SMTP id zt4so1635564bkb.19
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        bh=K16q/cVnEp1vA7pYGSrASiREUIQfbkAdXF6DwpMu94k=;
        b=onfu87opH8KZSAA1AZIdknvizpNA/49s78hGRYgtv41uxaLyOqvNne12ZPZ23tlFY8
         q4AYncGOCEte8MfV2jOQOTUTdrpUwP+Qde7sUn4HUoO6xmNsboMu2AAlZPTIGgOcp4QN
         IZ0pt9tDbc/z1ONKqllm4fiHBQvKxBIE6aRT4=
Received: by 10.204.135.140 with SMTP id n12mr394758bkt.182.1315742194945;
 Sun, 11 Sep 2011 04:56:34 -0700 (PDT)
Received: by 10.204.42.134 with HTTP; Sun, 11 Sep 2011 04:56:12 -0700 (PDT)
X-Google-Sender-Auth: 8k9uA_v04n38HuRY0BSNHDQWnJ8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181169>

Is something wrong with the git wiki?

$ ping http://git.wiki.kernel.org/
ping: unknown host http://git.wiki.kernel.org/

On the browser I get redirected to the OpenDNS page when there is a
DNS problem for some site. The OpenDNS cache also says there is no
such site. Was the git wiki affected in the recent DNS hack?

-- 
Suvayu

Open source is the future. It sets us free.
