From: pi song <pi.songs@gmail.com>
Subject: How to submit a big patch?
Date: Wed, 4 Mar 2009 00:24:31 +1100
Message-ID: <1b29507a0903030524xced15ecm6c7a255f7fa12ea4@mail.gmail.com>
Reply-To: pi.songs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 14:26:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeUdH-0003Pl-N3
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 14:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZCCNYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 08:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZCCNYd
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 08:24:33 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:46269 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbZCCNYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 08:24:33 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2794315rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 05:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=2SJ3pW43KxAqWkvJd4/mbSCU6VDZWnE7zSNa1rb+p+U=;
        b=Sk1dXMP/Q2YvxpMT0lqEe5lQ4lAPpvpSaIdxhpF78j9rG8yVHM3qKb0TKiY0FAGpqg
         h0kc27ZjUSpVCThMKxN1G9Nsi5esKIWAw/GfXZs0GnEYbbW6Xbfjn1UvqYi4gmYrpDCz
         q9i1+ITaH6ibVNcaWMatB6kKyjfIbZ362BUME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=lK8s2R83lrmgZxlwdXMNFHGaycHqhouPrJAH95YfyC3DvjMJgJOSvgvD3cj1xumkhf
         4Pq18h77QxKBBenWeOpujqwKiroz0LWXqARghVJtYlWVel9coyhuuPEUTc2M3VF3lJZz
         aM9+CXiyI/CNNDHQoTwK61vIuMv0lTU1yqfa4=
Received: by 10.143.15.14 with SMTP id s14mr3602720wfi.284.1236086671543; Tue, 
	03 Mar 2009 05:24:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112072>

I have got a  130KB patch. It doesn't really contain big changes but
just I split a big file into smaller files.
 I tried to cut and paste the patch file to gmail but seems gmail
trimmed my file. I tried paste into Outlook Express but my machine was
frozen. How should I submit the patch?

Pi Song
