From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Remote git-describe ?
Date: Wed, 24 Jan 2007 11:31:40 +0100
Message-ID: <38b2ab8a0701240231v5ec4acfasd838ececb316500d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 11:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9fQ6-0005X0-UK
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 11:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbXAXKbs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 05:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbXAXKbr
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 05:31:47 -0500
Received: from hu-out-0506.google.com ([72.14.214.227]:44883 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbXAXKbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 05:31:47 -0500
Received: by hu-out-0506.google.com with SMTP id 36so119389hui
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 02:31:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q0n86g9VBUpKnjtRKKOU6LFEj1Hk2pKF5hQKImlgdGsupBSTRGeKWqwXzhOJkoB8354lkbtpafUppHlhEJLMB7MC6mxea89JyBbSzSc/Tn5kQCPDlfjmMuhgURlReSFlBMrR0GTw5qkkkRGvezcrB90ZWFKzObY22PdfYmWQ7+s=
Received: by 10.49.10.3 with SMTP id n3mr318402nfi.1169634700797;
        Wed, 24 Jan 2007 02:31:40 -0800 (PST)
Received: by 10.49.30.4 with HTTP; Wed, 24 Jan 2007 02:31:40 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37623>

Hi !

I'm looking for a command that would give the same output than 'git
describe' but on a remote server.

Is this possible ?

thanks
-- 
Francis
