From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: installation problems with version 1.6.5.4
Date: Thu, 3 Dec 2009 20:09:21 +0000
Message-ID: <20091203200921.GA29478@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 21:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGHzW-000745-05
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 21:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbZLCUJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbZLCUJS
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 15:09:18 -0500
Received: from mhs.swan.ac.uk ([137.44.1.33]:42504 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbZLCUJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 15:09:17 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1NGHzO-0002AF-KH; Thu, 03 Dec 2009 20:09:22 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id B175036DF;
	Thu,  3 Dec 2009 20:09:21 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id A5BA274211; Thu,  3 Dec 2009 20:09:21 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134471>

Hi,

I get when installing 1.6.5.4

    GEN technical/api-index.txt
    ASCIIDOC technical/api-index.html
    ASCIIDOC git-add.xml
    XMLTO git-add.1
xmlto: unrecognised option `--stringparam'
usage: xmlto [OPTION]... FORMAT XML
OPTIONs are:
  -v              verbose output (-vv for very verbose)
  -x stylesheet   use the specified stylesheet instead of choosing one
  -m fragment     use the XSL fragment to customize the stylesheet
  -o directory    put output in the specified directory instead of
                  the current working directory
  -p postprocopts pass option to postprocessor
  --extensions    turn on stylesheet extensions for this tool chain
  --searchpath    colon-separated list of fallback directories
  --skip-validation
                  do not attempt to validate the input before processing


where

> xmlto --version
xmlto version 0.0.18

Couldn't find something on versions of xmlto required?

Oliver
