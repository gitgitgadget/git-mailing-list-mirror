From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Wither git-cheetah?
Date: Fri, 20 Jun 2008 11:53:34 -0400
Message-ID: <46a038f90806200853w481f4e59idb4777dfce96b5d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 17:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9iwb-0006Nu-MZ
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 17:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbYFTPxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 11:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbYFTPxh
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 11:53:37 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:52512 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbYFTPxg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 11:53:36 -0400
Received: by rn-out-0910.google.com with SMTP id k40so174132rnd.17
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=sSVPnU7JxoOGOA4FHgLeEWde/cO5AIgyEYdyRVSBmKA=;
        b=eIsvbLWwqRFKw6bqDMqsBgOpsTiM3gk94kZC7XNkepnP9cnoDK4zjr6DCB3QvnNn+p
         HaRoQWl1PZy/eMUxDZ148ssV0F/a4IesaNsrLkONqiCEXR2qdK4eo46I8lLHs2d8cuRU
         8eBxeQ1Tln0S5PC/HNUVzIm2TuLZUqjsMc9Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gZRIa3l4wOiVunusBo1KQfVhtyv+lr1YYLGwqAeRnfyllYfvyIbkkNjYApsUN211OG
         //YKqpjkdUTnkaUXvip6SSZWX69IZxNvLOad4nb3D6rnnob8dc5JR7MTolA3MEcw/1bu
         a9cueKifcPwI/2+t9J6bOLVWCiHladdFREIVQ=
Received: by 10.142.142.14 with SMTP id p14mr1392962wfd.315.1213977214124;
        Fri, 20 Jun 2008 08:53:34 -0700 (PDT)
Received: by 10.142.223.21 with HTTP; Fri, 20 Jun 2008 08:53:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85655>

Is anyone working on git-cheetah? What I thougtht at the time was a
joke from Johannes Schindelin (below) turned out to be a real "I'll
stop work now" thing.

Moodle.org is now seriously considering a move to GIT, and a
Tortoise-ish UI would be a good crutch for the transition. Anyone
played with TortoiseHg? http://tortoisehg.sourceforge.net/

On Fri, Apr 11, 2008 at 2:00 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 11 Apr 2008, John Goerzen wrote:
>> Think about it this way: once the Windows stuff for Git gets mature (to
>> the TortoiseGit level), there are going to be a lot of people using Git
>> that really *can't* operate a mail client because the only "mail client"
>> at their disposal is Outlook.
> That's a scary thought.  I will stop all my work on git-cheetah.

cheers,




m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
