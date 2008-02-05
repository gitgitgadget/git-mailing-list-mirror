From: "Ramagudi Naziir" <naziirr@gmail.com>
Subject: git-tag HEAD
Date: Tue, 5 Feb 2008 06:24:00 +0200
Message-ID: <dfb262380802042024p49bfb0c3v689946dba350ac01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 05:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMFMK-0006VS-Ud
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 05:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbYBEEYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 23:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbYBEEYC
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 23:24:02 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:50272 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbYBEEYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 23:24:00 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1614867rvb.1
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 20:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jliHMbzFjYaeQaRKnFK074gF9LAKrgzQX8eXPe01lg4=;
        b=U6em4Y5OZHjk9wIQqcLK4mjC9n9p8qx8M1ygK3KzMNt5yZtEtA8Jf3lykXCEWThLG4uvVhrXPTMTUceJHuA7eScCUogZWC/Y0vf1p0DrzDjadbdvHlvd+22tkIybmD7Fba3O8sDEYIftbMNGNeOxFifeLQM7owNqAsSLzI9Ijl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i6ZQXMQEDa+kWUA+REXa0rrpuAW9GTX0vS1CIYRQsctx9d7DcjoVcOV6HCnRC6FKXXCK9GXylRQqbFJjwuLQA5qBA+fDge1EgNuC0mSMMyAow1sVmr+SeLFRfJexqutli+f51Vs1w1w+36bxT1mB6jwyOyY0VIcnOwGfXWZ9lBI=
Received: by 10.141.49.6 with SMTP id b6mr5294876rvk.223.1202185440154;
        Mon, 04 Feb 2008 20:24:00 -0800 (PST)
Received: by 10.140.142.6 with HTTP; Mon, 4 Feb 2008 20:24:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72621>

Hello everyone,

I accidently executed the command "git-tag HEAD" in one of my git repositories.

Now every command I invoke, i.e. "git-log", begins with the warning:

"warning: refname 'HEAD' is ambiguous"

How can I fix this situation ? can I undo what I did ?

Thank you all in advance,
Naziir
