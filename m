From: Dilip M <dilipm79@gmail.com>
Subject: Installing full fledged git on solaris?
Date: Sun, 11 Oct 2009 17:56:10 +0530
Message-ID: <c94f8e120910110526r68e4abe1l269dc4b3ab22bac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 14:53:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwxvH-0002XE-Hp
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 14:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbZJKM1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 08:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbZJKM1H
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 08:27:07 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:53896 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbZJKM1G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 08:27:06 -0400
Received: by pxi9 with SMTP id 9so7933721pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 05:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=X8YAqw/WNMwJnPKBIS/TDNwRwH0BpDpqngVm4Ukd2DE=;
        b=ZoNVxbih+ZnHhQDg8eo+5OnuwJUUoVS1WF5JMDnH/me9Yoeppc3aOpAPN5C8wZuRSR
         c4CTx9GWhagrp02PI1lN68M8rQZMf3pvd7u1B5PtZ9tOKO8iCLhyoNQ+TrigV4GP+s7b
         F4yE5qoyEsjWmKsORynuS/twflLl1LxQgP6xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=VyEdHCmZr41VZ0LznuLcgml5Sg5t6MIBn3+i6cB9n8cXWpDxvoyHLpkbR8Is4zxXJd
         BQAoQDTMJIQgf6cSCOlZLPC0tnnNL4LNq+S51UC1vRV45UDL/DhAEgI/P7viN2OUP7Ce
         IrTN4e4NBPs6rc1dO4TAQcPHGpK7MwG8TFOPY=
Received: by 10.140.141.21 with SMTP id o21mr342450rvd.292.1255263990040; Sun, 
	11 Oct 2009 05:26:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129918>

Hello,


Has anyone has the list of pkg's to be installed on solaris 10 sparc,
to get the GIT compiled (with all features)..

thanks in advance for sharing...

-- 
Dilip
